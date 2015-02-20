import UIKit

private var FolderNameDidChangeContext = 0
private var FolderSizeDidChangeContext = 0

/** Wrapper view model for FolderData.

This view model implements the following convenience functions/properties:

Events:

- nameDidChange: block that gets called whenever underlying folder name changes
- sizeDidChange: block that gets called whenever underlying folder size changes
- nameOrSizeDidChange: block that gets called when either name or size changes

Convenience properties:

- sizeInKB: calculates folder size in KB
- nameAndSizeDescription: this is commonly used in our controllers, so now they can conveniently just use this property

We could get more creative. For example, we're blindly setting up KVO, but we could do it dynamically, depending on observation blocks client actually subscribe to.
*/
class FolderViewModel: NSObject {
	
	init(folder: FolderData) {
		// Assign folder we're handling.
		self.folder = folder
		
		// Let super class initiale
		super.init()
		
		// Setup KVO.
		self.folder.addObserver(self, forKeyPath: "name", options: nil, context: &FolderNameDidChangeContext)
		self.folder.addObserver(self, forKeyPath: "size", options: nil, context: &FolderSizeDidChangeContext)
	}
	
	deinit {
		// Remove observer when deallocating.
		self.folder.removeObserver(self, forKeyPath: "name")
		self.folder.removeObserver(self, forKeyPath: "size")
	}
	
	// MARK: - Overriden methods
	
	override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
		if context == &FolderNameDidChangeContext {
			println("FolderViewModel: folder name changed, notifying observer")
			self.nameDidChange?(name: self.folder.name)
			self.nameOrSizeDidChange?()
		} else if context == &FolderSizeDidChangeContext {
			println("FolderViewModel: folder size changed, notifying observer")
			self.sizeDidChange?(size: self.folder.size)
			self.nameOrSizeDidChange?()
		} else {
			super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
		}
	}
	
	// MARK: - Derived properties
	
	var sizeInKB: Int {
		return self.folder.size / 1024
	}
	
	var nameAndSizeDescription: String {
		return "\(self.folder.name) (\(self.sizeInKB) KB)"
	}
	
	// MARK: - Properties

	private (set) internal var folder: FolderData
	
	var nameDidChange: ((name: String) -> ())?
	var sizeDidChange: ((size: Int) -> ())?
	var nameOrSizeDidChange: dispatch_block_t?
}

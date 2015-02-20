import UIKit

private var FolderNameDidChangeContext = 0
private var FolderSizeDidChangeContext = 0

class ShowViewController: UIViewController {
	
	deinit {
		// Remove observer when deallocating.
		self.folder.removeObserver(self, forKeyPath: "name")
		self.folder.removeObserver(self, forKeyPath: "size")
	}
	
	// MARK: - Overriden methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Update our views with current data.
		self.updateUserInterface()
		
		// Setup KVO observer for our folder name and size.
		self.folder.addObserver(self, forKeyPath: "name", options: nil, context: &FolderNameDidChangeContext)
		self.folder.addObserver(self, forKeyPath: "size", options: nil, context: &FolderSizeDidChangeContext)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ChangeFolderNameScene" {
			// When change name view controller is instructed, pass it our folder.
			let destinationViewController = segue.destinationViewController as! ChangeFolderNameViewController
			destinationViewController.folder = self.folder
		}
	}
	
	override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
		if context == &FolderNameDidChangeContext || context == &FolderSizeDidChangeContext {
			println("ShowViewController: folder name or size changed")
			self.updateUserInterface()
		} else {
			super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
		}
	}
	
	// MARK: - User actions
	
	@IBAction func toggleFolderSizeChangeSimulation(sender: UISwitch) {
		println("ShowViewController: toggling folder size change simulation")
		self.folder.simulateSizeChanges = sender.on
	}
	
	// MARK: - Helper methods
	
	private func updateUserInterface() {
		println("ShowViewController: updating user interface")
		let sizeInKB = self.folder.size / 1024
		self.folderInfoLabel.text = "\(self.folder.name) (\(sizeInKB) KB)"
	}
	
	// MARK: - Properties
	
	private lazy var folder = DataStore.sharedInstance.folderDataForPath("/Some/Folder/Name")
	
	@IBOutlet weak var folderInfoLabel: UILabel!
	
}

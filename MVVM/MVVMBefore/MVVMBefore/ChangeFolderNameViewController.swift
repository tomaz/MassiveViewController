import UIKit

private var FolderNameDidChangeContext = 0
private var FolderSizeDidChangeContext = 0

class ChangeFolderNameViewController: UIViewController, UITextFieldDelegate {
	
	deinit {
		// Remove observer when deallocating.
		self.folder.removeObserver(self, forKeyPath: "name")
		self.folder.removeObserver(self, forKeyPath: "size")
	}
	
	// MARK: - Overriden methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Assign name to text field.
		self.nameTextField.text = self.folder.name
		
		// Update info label.
		self.updateUserInterface()
		
		// Setup KVO for name and size changes on assigned folder.
		self.folder.addObserver(self, forKeyPath: "name", options: nil, context: &FolderNameDidChangeContext)
		self.folder.addObserver(self, forKeyPath: "size", options: nil, context: &FolderSizeDidChangeContext)
	}
	
	override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
		if context == &FolderNameDidChangeContext || context == &FolderSizeDidChangeContext {
			// When name or size changes, update info label at the bottom.
			println("--> ChangeFolderNameViewController: folder name or size changed")
			self.updateUserInterface()
		} else {
			super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
		}
	}

	// MARK: - Helper methods
	
	private func updateUserInterface() {
		println("ChangeFolderNameViewController: updating user interface")
		let sizeInKB = self.folder.size / 1024
		self.infoLabel.text = "\(self.folder.name) (\(sizeInKB) KB)"
	}
	
	// MARK: - UITextFieldDelegate implementation
	
	func textFieldDidEndEditing(textField: UITextField) {
		// Store new name to FolderData when text field ends editing.
		println("ChangeFolderNameViewController: changing name to \(self.nameTextField.text)")
		self.folder.name = self.nameTextField.text
	}

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		// Hide keyboard when done button is pressed.
		textField.resignFirstResponder()
		return false
	}
	
	// MARK: - Properties
	
	var folder: FolderData!
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var infoLabel: UILabel!
	
}

import UIKit

class ChangeFolderNameViewController: UIViewController, UITextFieldDelegate {
	
	// MARK: - Overriden methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Assign name to text field. Note we could also use self.viewModel.folder.name...
		self.nameTextField.text = self.folder.name
		
		// Update info label.
		self.updateUserInterface()
	}
	
	// MARK: - Helper methods
	
	private func updateUserInterface() {
		println("ChangeFolderNameViewController: updating user interface")
		self.infoLabel.text = self.viewModel.nameAndSizeDescription
	}
	
	// MARK: - UITextFieldDelegate implementation
	
	func textFieldDidEndEditing(textField: UITextField) {
		// Store new name to FolderData when text field ends editing. Note we could also use self.viewModel.folder.name = ...
		println("--> ChangeFolderNameViewController: changing name to \(self.nameTextField.text)")
		self.folder.name = self.nameTextField.text
	}

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		// Hide keyboard when done button is pressed.
		textField.resignFirstResponder()
		return false
	}
	
	// MARK: - Properties
	
	var viewModel: FolderViewModel!
	
	var folder: FolderData! {
		didSet {
			println("ChangeFolderNameViewController: folder changed, preparing new view model")
			
			// When folder changes, prepare new view model.
			self.viewModel = FolderViewModel(folder: self.folder)
			
			// Setup observations.
			self.viewModel.nameOrSizeDidChange = {
				println("ChangeFolderNameViewController: name or size changed")
				self.updateUserInterface()
			}
		}
	}
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var infoLabel: UILabel!
	
}

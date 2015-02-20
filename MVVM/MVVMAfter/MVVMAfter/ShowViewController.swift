import UIKit

class ShowViewController: UIViewController {
	
	// MARK: - Overriden methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Establish our view model.
		self.viewModel = FolderViewModel(folder: self.folder)
		
		// Update our views with current data.
		self.updateUserInterface()
		
		// When folder's name or size changes, update our views.
		self.viewModel.nameOrSizeDidChange = {
			println("ShowViewController: folder name changed")
			self.updateUserInterface()
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ChangeFolderNameScene" {
			// When change name view controller is instructed, pass it our folder.
			let destinationViewController = segue.destinationViewController as! ChangeFolderNameViewController
			destinationViewController.folder = self.folder
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
		self.folderInfoLabel.text = self.viewModel.nameAndSizeDescription
	}
	
	// MARK: - Properties
	
	private var viewModel: FolderViewModel!
	
	private lazy var folder = DataStore.sharedInstance.folderDataForPath("/Some/Folder/Name")
	
	@IBOutlet weak var folderInfoLabel: UILabel!
	
}

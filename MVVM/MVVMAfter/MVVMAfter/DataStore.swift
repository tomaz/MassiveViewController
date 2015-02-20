import Foundation

/** This is where we get FolderData from.
*/
class DataStore {
	
	class var sharedInstance: DataStore {
		struct Static {
			static var token: dispatch_once_t = 0
			static var instance: DataStore? = nil
		}
		
		dispatch_once(&Static.token) {
			Static.instance = DataStore()
		}
		
		return Static.instance!
	}
	
	func folderDataForPath(path: String) -> FolderData {
		// Note we're caching folders by their paths so next request for the same folder would return previous FolderData instance.
		if let existingFolder = self.foldersByPaths[path] {
			return existingFolder
		}
		
		// Prepare folder data for given path.
		let result = FolderData()
		result.name = path.lastPathComponent
		result.size = 0
		
		// Add folder to our cache.
		self.foldersByPaths[path] = result
		
		// Return newly created instance.
		return result
	}
	
	private lazy var foldersByPaths = [String:FolderData]()
	
}

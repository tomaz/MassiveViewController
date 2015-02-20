import Foundation

class FolderData: NSObject {
	
	override init() {
		self.name = ""
		self.size = 0
		self.simulateSizeChanges = true
		
		super.init()
	}
	
	dynamic var name: String {
		willSet {
			println("FolderData: Changing \(self.name) -> \(newValue)")
		}
	}
	
	dynamic var size: Int {
		willSet {
			println("FolderData: Changing \(self.name) size \(self.size) -> \(newValue)")
		}
	}
	
	// MARK: - Real folder simulation...
	
	var simulateSizeChanges: Bool {
		willSet {
			if (newValue) {
				if self.timer != nil {
					self.timer.invalidate()
				}
				
				self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "simulateSizeTimerTick", userInfo: nil, repeats: true)
			} else {
				self.timer.invalidate()
				self.timer = nil
			}
		}
	}
	
	func simulateSizeTimerTick() {
		println("--> FolderData: simulating size increase")
		self.size += 1024
	}
	
	private var timer: NSTimer!
	
}

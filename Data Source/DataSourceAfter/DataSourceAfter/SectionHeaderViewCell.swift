/*

Created by Tomaz Kragelj on 31.01.2015.
Copyright (c) 2015 Gentle Bytes.

*/

import UIKit

class SectionHeaderViewCell: UICollectionReusableView {
	
	func configureWithSection(section: SectionData) {
		self.titleLabel.text = section.title
		self.countLabel.text = NSLocalizedString("\(section.items.count) items", comment: "")
	}
	
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var countLabel: UILabel!
	
}

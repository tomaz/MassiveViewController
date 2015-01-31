/*

Created by Tomaz Kragelj on 31.01.2015.
Copyright (c) 2015 Gentle Bytes.

*/

import UIKit

class ItemViewCell: UICollectionViewCell {
	
	func configureWithItem(item: ItemData, section: SectionData) {
		self.titleLabel.text = "\(item.title) of \(section.title)"
	}
	
	@IBOutlet var titleLabel: UILabel!
	
}

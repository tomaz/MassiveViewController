/*

Created by Tomaz Kragelj on 31.01.2015.
Copyright (c) 2015 Gentle Bytes.

*/

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.dataSource = ItemsDataSource(collectionView: self.collectionView)
		
		self.collectionView.dataSource = self.dataSource
	}
	
	// MARK: - UICollectionViewDelegate implementation
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		let sectionData = self.dataSource.sections[indexPath.section]
		let itemData = sectionData.items[indexPath.item]

		let title = NSLocalizedString("Wonderful!", comment: "")
		let message = NSLocalizedString("You just selected \(itemData.title) of \(sectionData.title)! That's a great choice!", comment: "")
		let button = NSLocalizedString("I know", comment: "")
		
		let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
		controller.addAction(UIAlertAction(title: button, style: .Default, handler: nil))
		
		self.presentViewController(controller, animated: true, completion: nil)
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout implementatio
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		let layout = collectionViewLayout as UICollectionViewFlowLayout
		return CGSizeMake(CGRectGetWidth(collectionView.frame), layout.itemSize.height)
	}
	
	// MARK: - Properties
	
	private var dataSource: ItemsDataSource!
	
	@IBOutlet var collectionView: UICollectionView!

}


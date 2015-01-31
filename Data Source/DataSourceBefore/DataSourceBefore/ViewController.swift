/*

Created by Tomaz Kragelj on 31.01.2015.
Copyright (c) 2015 Gentle Bytes.

*/

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - UICollectionViewDataSource implementation
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return self.sections.count
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let sectionData = self.sections[section]
		return sectionData.items.count
	}
	
	func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
		let sectionData = self.sections[indexPath.section]
		
		let result = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionCell", forIndexPath: indexPath) as SectionHeaderViewCell
		result.configureWithSection(sectionData)
		return result;
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let sectionData = self.sections[indexPath.section]
		let itemData = sectionData.items[indexPath.item]
		
		let result = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as ItemViewCell
		result.configureWithItem(itemData, section: sectionData)
		return result
	}
	
	// MARK: - UICollectionViewDelegate implementation
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		let sectionData = self.sections[indexPath.section]
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
	
	private lazy var sections = testSections()

	@IBOutlet var collectionView: UICollectionView!

}


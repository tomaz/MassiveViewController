/*

Created by Tomaz Kragelj on 31.01.2015.
Copyright (c) 2015 Gentle Bytes.

*/

import UIKit

class ItemsDataSource: NSObject, UICollectionViewDataSource {
	
	init(collectionView: UICollectionView) {
		self.sections = testSections()
		self.collectionView = collectionView
		
		super.init()
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
	
	// MARK: - Properties
	
	private (set) internal var sections: [SectionData]
	private var collectionView: UICollectionView
	
}

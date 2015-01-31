/*

Created by Tomaz Kragelj on 31.01.2015.
Copyright (c) 2015 Gentle Bytes.

*/

import Foundation

class SectionData {
	init(title: String, items: [ItemData]) {
		self.title = title
		self.items = items
	}
	
	lazy var title = ""
	lazy var items = [ItemData]()
}

class ItemData {
	init(title: String) {
		self.title = title
	}
	
	lazy var title = ""
}

func testSections() -> [SectionData] {
	return [
		SectionData(title: "Section 1", items: [
			ItemData(title: "Item 1"),
			ItemData(title: "Item 2"),
			ItemData(title: "Item 3"),
		]),
		
		SectionData(title: "Section 2", items: [
			ItemData(title: "Item 1"),
			ItemData(title: "Item 2"),
			ItemData(title: "Item 3"),
			ItemData(title: "Item 4"),
			ItemData(title: "Item 5"),
			ItemData(title: "Item 6"),
			ItemData(title: "Item 7"),
		]),
		
		SectionData(title: "Section 3", items: [
			ItemData(title: "Item 1"),
			ItemData(title: "Item 2"),
		]),
	]
}
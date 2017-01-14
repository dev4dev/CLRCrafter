//
//  Colors+Additions.swift
//  CLRCrafterFramework
//
//  Created by Alex Antonyuk on 1/14/17.
//  Copyright © 2017 Alex Antonyuk. All rights reserved.
//

import Foundation

public extension NSColorList {
	public convenience init(name: String, colors: Colors) {
		self.init(name: name)
		let keys = colors.keys.sorted()
		(0..<keys.count).forEach({ index in
			let colorName = keys[index]
			if let color = colors[colorName] {
				insertColor(color, key: colorName, at: index)
			}
		})
	}
}

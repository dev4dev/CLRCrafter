//
//  String+Additions.swift
//  CLRApp
//
//  Created by Alex Antonyuk on 1/14/17.
//  Copyright © 2017 Alex Antonyuk. All rights reserved.
//

import Foundation

extension String {
	func sanitize() -> String {
		return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
	}
}

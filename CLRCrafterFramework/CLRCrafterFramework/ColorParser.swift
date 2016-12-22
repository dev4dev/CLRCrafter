//
//  ColorParser.swift
//  CLRCrafterFramework
//
//  Created by Alex Antonyuk on 12/20/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

import AppKit

extension String {
	func matches(regExp: NSRegularExpression) -> Bool {
		return regExp.numberOfMatches(in: self, options: [], range: NSMakeRange(0, characters.count)) > 0
	}

	func rangeFrom(range: NSRange) -> Range<String.Index> {
		let start = index(startIndex, offsetBy: range.location)
		let end = index(start, offsetBy: range.length, limitedBy: endIndex)

		return Range<String.Index>(uncheckedBounds: (lower: start, upper: end!))
	}

	func substring(with range: NSRange) -> String {
		return substring(with: rangeFrom(range: range))
	}
}

extension Array {
	func slice(length: Int) -> [[Element]] {
		var indexes: [Range<Index>] = []
		var index = startIndex
		while index < endIndex {
			let end = self.index(index, offsetBy: length, limitedBy: endIndex) ?? endIndex
			indexes.append(index..<end)
			index = end
		}

		return indexes.map({ range -> [Element] in
			return Array(self[range])
		})
	}
}

public typealias Colors = [String: NSColor]

public struct ColorsParser {

	public enum ParsingError: Error {
		case dataIsInconsistent(message: String)
		case unimplemented
	}

	enum SourceType {
		case colorThenName
		case nameThenColor
		case nameEqualColor
		case colorEqualName

		static var colorRegExp = try! NSRegularExpression(pattern: "rgba\\((\\d+), (\\d+), (\\d+), (\\d+)\\)", options: [.caseInsensitive])

		static func detect(lines: [String]) -> SourceType? {
			guard let firstLine = lines.first else { return nil }

			let hasEqual = firstLine.characters.index(of: "=") != nil
			if hasEqual {
				let parts = firstLine.components(separatedBy: "=").map({ part in
					return part.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
				})

				if parts[0].matches(regExp: colorRegExp) {
					return .colorEqualName
				} else {
					return .nameEqualColor
				}
			} else {
				guard lines.count > 1 else { return nil }
				let secondLine = lines[1]

				if firstLine.matches(regExp: colorRegExp) && !secondLine.matches(regExp: colorRegExp) {
					return .colorThenName
				} else if !firstLine.matches(regExp: colorRegExp) && secondLine.matches(regExp: colorRegExp) {
					return .nameThenColor
				}
			}

			return nil
		}

		static func color(from string: String) -> NSColor? {
			let matches = colorRegExp.matches(in: string, options: [], range: NSMakeRange(0, string.characters.count)).first!

			var components: [CGFloat] = []
			for r in (1..<matches.numberOfRanges) {
				let range = matches.rangeAt(r)
				let s = string.substring(with: range)
				components.append(CGFloat(Int(s.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!) / 255.0)
			}
			if components.count == 4 {
				return NSColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
			}

			return nil
		}

		func parse(lines: [String]) throws -> Colors {
			switch self {
			case .colorThenName:
				guard lines.count % 2 == 0 else { throw ParsingError.dataIsInconsistent(message: "Lines count should be even") }

				var result: Colors = [:]
				let pairs = lines.slice(length: 2)
				for pair in pairs {
					if let color = SourceType.color(from: pair.first!),
						let name = pair.last {
						result[name] = color
					}
				}
				return result
			case .nameThenColor:
				throw ColorsParser.ParsingError.unimplemented
			case .nameEqualColor:
				throw ColorsParser.ParsingError.unimplemented
			case .colorEqualName:
				var result: Colors = [:]
				for line in lines {
					let pair = line.components(separatedBy: "=").map({ part in
						part.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
					})
					if let color = SourceType.color(from: pair.first!),
						let name = pair.last {
						result[name] = color
					}
				}
				return result
			}
		}
	}

	public static func parse(data: String) throws -> Colors {
		let lines = data.components(separatedBy: CharacterSet.newlines).map { line in
			return line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}.filter { line in
			!line.isEmpty
		}

		guard let type = SourceType.detect(lines: lines) else { return [:] }
		return try type.parse(lines: lines)
	}
}

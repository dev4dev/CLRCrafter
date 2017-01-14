//
//  ParserTest.swift
//  CLRCrafter
//
//  Created by Alex Antonyuk on 12/20/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

import XCTest
@testable import CLRCrafterFramework

class ParserTest: XCTestCase {

	func findTextResource(name: String) -> URL? {
		return Bundle(for: type(of: self)).url(forResource: name, withExtension: "txt")
	}

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testSympliDefaultCopyPasteFormat() {
		// prepare
		let data = try! String(contentsOf: findTextResource(name: "example1")!, encoding: String.Encoding.utf8)

		// action
		do {
			let result = try ColorsParser.parse(data: data)

			// test
			XCTAssertEqual(result.count, 45, "Colors count sould be 45")
			print(result)
		}
		catch (let error) {
			print(error)
		}
	}

	func testColorEqualNameFormat() {
		// prepare
		let data = try! String(contentsOf: findTextResource(name: "example2")!, encoding: String.Encoding.utf8)

		// action
		do {
			let result = try ColorsParser.parse(data: data)

			// test
			XCTAssertEqual(result.count, 45, "Colors count sould be 45")
			print(result)
		}
		catch (let error) {
			print(error)
		}
	}
}

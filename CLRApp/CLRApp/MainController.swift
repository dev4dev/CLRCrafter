//
//  MainController.swift
//  CLRApp
//
//  Created by Alex Antonyuk on 12/23/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

import Cocoa
import CLRCrafterFramework

class MainController: NSWindowController {

	@IBOutlet var textView: NSTextView!

	override var windowNibName: String? {
		return String(describing: type(of: self))
	}

	override func windowDidLoad() {
		super.windowDidLoad()

		// Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
	}

	@IBAction func onSaveTap(_ sender: NSButton) {
		guard let colorsString = textView.string else { return }

		do {
			let colors = try ColorsParser.parse(data: colorsString)
			guard !colors.isEmpty else {
				let alert = NSAlert(info: "There are no colors at all")
				alert.beginSheetModal(for: window!, completionHandler: nil)
				return
			}
			NSAlert().prompt(with: "Colors List name", in: window!, callback: { [unowned self] name in
				guard let name = name?.sanitize(), !name.isEmpty else { return }
				self.store(colors: colors, with: name)
			})
		} catch let error as ColorsParser.ParsingError {
			print("error \(error)")
		} catch {
			print("what?")
		}
	}

	private func store(colors: Colors, with name: String) {
		guard let library = try? FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return }

		let destination = library.appendingPathComponent("Colors/\(name).clr")
		let list = NSColorList(name: name, colors: colors)

		print("Saving to: \(destination.path)")
		if !list.write(toFile: destination.path) {
			print("Saving error")
		}
	}
}

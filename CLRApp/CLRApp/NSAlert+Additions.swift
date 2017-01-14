//
//  NSAlert+Additions.swift
//  CLRApp
//
//  Created by Alex Antonyuk on 1/14/17.
//  Copyright © 2017 Alex Antonyuk. All rights reserved.
//

import AppKit

extension NSAlert {

	func prompt(with message: String, in window: NSWindow, callback: @escaping (String?) -> Void) {
		let alert = NSAlert()
		alert.addButton(withTitle: "OK")
		alert.addButton(withTitle: "Cancel")
		alert.messageText = message

		let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200.0, height: 24.0))

		alert.accessoryView = textField

		alert.beginSheetModal(for: window) { response in
			if response == NSAlertFirstButtonReturn {
				callback(textField.stringValue)
			} else {
				callback(nil)
			}
		}
	}

	convenience init(info: String) {
		self.init()
		alertStyle = .informational
		messageText = info
	}
}

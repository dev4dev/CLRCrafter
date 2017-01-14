//
//  MainController.swift
//  CLRApp
//
//  Created by Alex Antonyuk on 12/23/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

import Cocoa

class MainController: NSWindowController {

	override var windowNibName: String? {
		return String(describing: type(of: self))
	}

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}

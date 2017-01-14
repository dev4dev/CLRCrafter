//
//  AppDelegate.swift
//  CLRApp
//
//  Created by Alex Antonyuk on 12/23/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	var mainWC = MainController()


	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		mainWC.showWindow(self)
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}

}


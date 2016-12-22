//
//  main.swift
//  CLRCrafter
//
//  Created by Alex Antonyuk on 11/8/16.
//  Copyright © 2016 Alex Antonyuk. All rights reserved.
//

import AppKit
import CLRCrafterFramework

guard CommandLine.argc > 1 else {
	print("Provide file name")
	exit(-1)
}

let fileName = CommandLine.arguments[1]
let outputName = (CommandLine.arguments.count == 3) ? CommandLine.arguments[2] : "output.clr"


if let str = try? String(contentsOfFile: fileName).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
	do {
		let colors = try ColorsParser.parse(data: str)
		let list = NSColorList(name: "Converted")
		let keys = colors.keys.sorted()
		(0..<keys.count).forEach({ index in
			let name = keys[index]
			let color = colors[name]
			list.insertColor(color!, key: name, at: index)
		})
		list.write(toFile: outputName)
	} catch (let error as ColorsParser.ParsingError) {
		print("Eh...Parsing error \(error)")
	}
} else {
	print("Bad file \(fileName)")
}


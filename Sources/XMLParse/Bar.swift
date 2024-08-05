//
//	Bar.swift
//	music-notation-import
//
//	Created by Steven Woolgar on 2021-03-30.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

public struct Bar: XMLObjectDeserialization {
	var clef: String
	var voices: [Int]

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		let voices: String = try node["Voices"].value()
		let voicesArray = voices.split(separator: " ")

		return try Bar(
			clef: node["Clef"].value(),
			voices: voicesArray.compactMap { Int($0) }
		)
	}
}

//
//	Bar.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-03-30.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

//	<Bar id="0">
//	  <Clef>G2</Clef>
//	  <Voices>0 -1 -1 -1</Voices>
//	</Bar>

// The root element of this is the `<Bars>` array
public struct Bar: XMLObjectDeserialization {
	static let nodeKey = "Bar"
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

//
//	PrimaryTuplet.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-10-18.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

//<Rhythm id="6">
//  <NoteValue>16th</NoteValue>
//  <PrimaryTuplet num="3" den="2" />    <<<<<<<<
//</Rhythm>

public struct PrimaryTuplet: XMLObjectDeserialization {
	static let nodeKey = "PrimaryTuplet"
	var number: Int
	var density: Int

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try PrimaryTuplet(
			number: node.value(ofAttribute: "num"),
			density: node.value(ofAttribute: "den")
		)
	}
}

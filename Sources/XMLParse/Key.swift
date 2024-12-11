//
//	Key.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-10.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <Key>
//   <AccidentalCount>4</AccidentalCount>
//   <Mode>Major</Mode>
//   <TransposeAs>Sharps</TransposeAs>
// </Key>

public struct Key: XMLObjectDeserialization {
	static let nodeKey = "Key"
	var accidentalCount: Int
	var mode: String
	var transposeAs: String

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Key(
			accidentalCount: node["AccidentalCount"].value(),
			mode: node["Mode"].value(),
			transposeAs: node["TransposeAs"].value()
		)
	}
}

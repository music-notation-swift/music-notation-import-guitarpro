//
//	Transpose.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <Transpose>
//	<Chromatic>0</Chromatic>
//	<Octave>0</Octave>
// </Transpose>

public struct Transpose: XMLObjectDeserialization {
	static let nodeKey = "Transpose"
	var chromatic: Bool
	var octave: Int

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Transpose(
			chromatic: Bool(node["Chromatic"].value()),
			octave: node["Octave"].value()
		)
	}
}

//
//	Rhythm.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

public struct Rhythm: XMLObjectDeserialization {
	var id: Int
	var noteValue: NoteValue
	var augmentationDot: Int?
	var primaryTuplet: PrimaryTuplet?

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Rhythm(
			id: node.value(ofAttribute: "id"),
			noteValue: node[NoteValue.nodeKey].value(),
			augmentationDot: node["AugmentationDot"].value(ofAttribute: "count"),
			primaryTuplet: node[PrimaryTuplet.nodeKey].value()
		)
	}
}

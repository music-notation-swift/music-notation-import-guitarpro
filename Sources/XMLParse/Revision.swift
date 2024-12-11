//
//	Revision.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-03-30.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import SWXMLHash

//<GPIF>
//  <GPVersion>8.1.3</GPVersion>
//  <GPRevision required="12024" recommended="13000">13007</GPRevision>
// ...

public struct Revision: XMLObjectDeserialization {
	static let nodeKey = "GPRevision"
	var value: Int

	var required: Int
	var recommended: Int

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Revision(
			value: node.value(),
			required: node.value(ofAttribute: "required"),
			recommended: node.value(ofAttribute: "recommended")
		)
	}
}

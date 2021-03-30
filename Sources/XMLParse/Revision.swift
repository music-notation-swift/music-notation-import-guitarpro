//
//	Revision.swift
//	music-notation-import
//
//	Created by Steven Woolgar on 2021-03-30.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import SWXMLHash

public struct Revision: XMLIndexerDeserializable {
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

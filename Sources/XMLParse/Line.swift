//
//	Lyrics.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-10.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

//<Line>
//  <Text>
//    Guess who  just  got  back __  to- day? __
//    Those wild- eyed boys __ that had been a- way __
//  </Text>
//  <Offset>0</Offset>
//</Line>

public struct Line: XMLObjectDeserialization {
	var text: String
	var offset: Int

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Line(
			text: node["Text"].value(),
			offset: node["Offset"].value()
		)
	}
}

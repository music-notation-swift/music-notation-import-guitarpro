//
//	Lyrics.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-10.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <Lyrics dispatched="true">
//	<Line>
//	  <Text>Something, something, something</Text>
//	  <Offset>0</Offset>
//	</Line>
//	<Line>
//	  <Text>Else, else, else</Text>
//	  <Offset>0</Offset>
//	</Line>
//	<Line>
//	  <Text>
//	  </Text>
//	  <Offset>0</Offset>
//	</Line>
//	<Line>
//	  <Text>
//	  </Text>
//	  <Offset>0</Offset>
//	</Line>
//	<Line>
//	  <Text>
//	  </Text>
//	  <Offset>0</Offset>
//	</Line>
// </Lyrics>

public struct Lyrics: XMLObjectDeserialization {
	static let nodeKey = "Lyrics"
	var dispatched: Bool
	var lines: [Line]

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Lyrics(
			dispatched: node.value(ofAttribute: "dispatched"),
			lines: node[Line.nodeKey].value()
		)
	}
}

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
//	  <Text>
// <![CDATA[]]>
//	  </Text>
//	  <Offset>0</Offset>
//	</Line>
//	<Line>
//	  <Text>
// <![CDATA[]]>
//	  </Text>
//	  <Offset>0</Offset>
//	</Line>
//	<Line>
//	  <Text>
// <![CDATA[]]>
//	  </Text>
//	  <Offset>0</Offset>
//	</Line>
//	<Line>
//	  <Text>
// <![CDATA[]]>
//	  </Text>
//	  <Offset>0</Offset>
//	</Line>
//	<Line>
//	  <Text>
// <![CDATA[]]>
//	  </Text>
//	  <Offset>0</Offset>
//	</Line>
// </Lyrics>

public struct Lyrics: XMLObjectDeserialization {
	var dispatched: Bool

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Lyrics(
			dispatched: node.value(ofAttribute: "dispatched")
		)
	}
}

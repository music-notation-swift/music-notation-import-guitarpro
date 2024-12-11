//
//	MasterBar.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-10.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <MasterBar>
//   <Key>
//     <AccidentalCount>-4</AccidentalCount>
//     <Mode>Major</Mode>
//     <TransposeAs>Sharps</TransposeAs>
//   </Key>
//   <Time>4/4</Time>
//   <Section>
//     <Letter>
//       <![CDATA[A]]>
//     </Letter>
//     <Text>
//       <![CDATA[Intro]]>
//     </Text>
//   </Section>
//   <TripletFeel>Triplet8th</TripletFeel>
//   <Bars>0 1 2 3 4 5</Bars>
// </MasterBar>

/// NB: As per the XML file, order of masterbars are important.

public struct MasterBar: XMLObjectDeserialization {
	static let nodeKey = "MasterBar"
	var key: Key
	var timeSignature: TimeSignature

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try MasterBar(
			key: node[Key.nodeKey].value(),
			timeSignature: node[TimeSignature.nodeKey].value()
		)
	}
}

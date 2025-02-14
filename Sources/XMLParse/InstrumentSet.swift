//
//	InstrumentSet.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <InstrumentSet>
//	<Name>Electric Piano</Name>
//	<Type>electricPiano</Type>
//	<LineCount>5</LineCount>
//	<Elements>
//	  <Element>
//		<Name>Pitched</Name>
//		<Type>pitched</Type>
//		<SoundbankName></SoundbankName>
//		<Articulations>
//		  <Articulation>
//			<Name></Name>
//			<StaffLine>0</StaffLine>
//			<Noteheads>noteheadBlack noteheadHalf noteheadWhole</Noteheads>
//			<TechniquePlacement>outside</TechniquePlacement>
//			<TechniqueSymbol></TechniqueSymbol>
//			<InputMidiNumbers></InputMidiNumbers>
//			<OutputRSESound></OutputRSESound>
//			<OutputMidiNumber>0</OutputMidiNumber>
//		  </Articulation>
//		</Articulations>
//	  </Element>
//	</Elements>
//  </InstrumentSet>

public struct InstrumentSet: XMLObjectDeserialization {
	static let nodeKey = "InstrumentSet"
	var name: String
	var instrumentType: String

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try InstrumentSet(
			name: node["Name"].value(),
			instrumentType: node["Type"].value()
		)
	}
}

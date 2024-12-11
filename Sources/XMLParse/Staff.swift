//
//	Staff.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-10-10.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <Staff>
//  <Properties>
//	<Property name="CapoFret"><Fret>0</Fret></Property>
//	<Property name="FretCount"><Number>24</Number></Property>
//	<Property name="PartialCapoFret"><Fret>0</Fret></Property>
//	<Property name="PartialCapoStringFlags"><Bitset>000000</Bitset></Property>
//	<Property name="Tuning"><Pitches>40 45 50 55 59 64</Pitches><Flat></Flat><Instrument>Guitar</Instrument><Label><![CDATA[]]></Label><LabelVisible>true</LabelVisible></Property>
//	<Property name="ChordCollection"><Items /></Property>
//	<Property name="ChordWorkingSet"><Items /></Property>
//	<Property name="DiagramCollection"><Items /></Property>
//	<Property name="DiagramWorkingSet"><Items /></Property>
//	<Property name="TuningFlat"><Enable /></Property>
//	<Name><![CDATA[Standard]]></Name>
//  </Properties>
// </Staff>

// NB: The <Properties> array is malformed XML in that it isn't just a list of <Property> entries, but also
// contains a <Name> entry. I will have to manually pull all of array entries out and then the <Name>.
public struct Staff: XMLObjectDeserialization {
	static let nodeKey = "Staff"

	var properties: [StaffProperty]
	var name: String

	var fretCount: Int {
		var fretCountValue = 24
		let fretCountProperty = properties.first(where: { $0 =~ .fretCount(0) })

		if let fretCountProperty, case let .fretCount(value) = fretCountProperty {
			fretCountValue = value
		}

		return fretCountValue
	}

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Staff(
			properties: node["Properties"][StaffProperty.nodeKey].value(),
			name: node["Properties"]["Name"].value()
		)
	}
}

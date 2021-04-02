//
//	TrackTests.swift
//	music-notation-import-tests
//
//	Created by Steven Woolgar on 2021-04-01.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import XCTest
import SWXMLHash
@testable import MusicNotationImportGuitarPro

let testStaff1 = """
<Staff>
	<Properties>
		<Property name="CapoFret">
			<Fret>0</Fret>
		</Property>
		<Property name="FretCount">
			<Number>24</Number>
		</Property>
		<Property name="PartialCapoFret">
			<Fret>0</Fret>
		</Property>
		<Property name="PartialCapoStringFlags">
			<Bitset>000000</Bitset>
		</Property>
		<Property name="Tuning">
			<Pitches>40 45 50 55 59 64</Pitches>
			<Flat></Flat>
			<Instrument>Guitar</Instrument>
			<Label><![CDATA[]]></Label>
			<LabelVisible>true</LabelVisible>
		</Property>
		<Property name="ChordCollection">
			<Items/>
		</Property>
		<Property name="ChordWorkingSet">
			<Items/>
		</Property>
		<Property name="DiagramCollection">
			<Items/>
		</Property>
		<Property name="DiagramWorkingSet">
			<Items/>
		</Property>
		<Property name="TuningFlat">
			<Enable />
		</Property>
		<Name><![CDATA[Standard]]></Name>
	</Properties>
</Staff>
"""

/// GuitarPro 7 has a concept of a Track. This is part of a song, which roughly corresponds to a MusicNotation.Part.
class StaffTests: XCTestCase {
	func testParse() {
		let xmlParser = SWXMLHash.parse(testStaff1)

		do {
			let staff1: Staff = try xmlParser["Staff"].value()
			XCTAssertEqual(staff1.name, "Standard")
			XCTAssertEqual(staff1.properties[0], .capoFret(0))
		} catch {
			XCTFail("\(error)")
		}
	}
}

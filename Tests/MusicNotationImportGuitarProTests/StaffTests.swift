//
//	StaffTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2021-04-01.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

/// GuitarPro 7 has a concept of a Track. This is part of a song, which roughly corresponds to a MusicNotation.Part.
@Suite final class StaffTests {
	@Test func parse() async throws {
		let xmlParser = XMLHash.parse(testStaff0)

		let staff1: Staff = try xmlParser["Staff"].value()
		#expect(staff1.name == "Standard")
		#expect(staff1.properties.count == 10)
		#expect(staff1.properties[0] == .capoFret(0))
		#expect(staff1.name == "Standard")
	}

	@Test func multipleStaves() async throws {
		let xmlParser = XMLHash.parse(testStaves0)

		let staves: [Staff] = try xmlParser["Staves"]["Staff"].value()
		#expect(staves.count == 1)
		#expect(staves[0].properties[0] == .capoFret(0))
	}
}

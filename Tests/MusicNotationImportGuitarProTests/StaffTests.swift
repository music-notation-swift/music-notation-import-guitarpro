//
//	StaffTests.swift
//	music-notation-import-tests
//
//	Created by Steven Woolgar on 2021-04-01.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import XCTest

/// GuitarPro 7 has a concept of a Track. This is part of a song, which roughly corresponds to a MusicNotation.Part.
class StaffTests: XCTestCase {
	func testParse() throws {
		let xmlParser = SWXMLHash.parse(testStaff0)
		print("\(testStaff0)")

		do {
			let staff1: Staff = try xmlParser["Staff"].value()
			XCTAssertEqual(staff1.name, "Standard")
			XCTAssertEqual(staff1.properties.count, 10)
			XCTAssertEqual(staff1.properties[0], .capoFret(0))
			XCTAssertEqual(staff1.name, "Standard")
		} catch {
			XCTFail("\(error)")
		}
	}

	func testMultipleStaves() {
		let xmlParser = SWXMLHash.parse(testStaves0)
		print("\(testStaves0)")

		do {
			let staves: [Staff] = try xmlParser["Staves"]["Staff"].value()
			XCTAssertEqual(staves.count, 1)
			XCTAssertEqual(staves[0].properties[0], .capoFret(0))
		} catch {
			XCTFail("\(error)")
		}
	}
}

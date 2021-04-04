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

let testTrack0 = track0Open + testTrackBody + trackClose
let testTrack1 = track1Open + testTrackBody + trackClose
let testTrack2 = track2Open + testTrackBody + trackClose

/// GuitarPro 7 has a concept of a Track. This is part of a song, which roughly corresponds to a MusicNotation.Part.
class TrackTests: XCTestCase {
	func testParse() {
		let xmlParser = SWXMLHash.parse(testTrack0)

		do {
			let track0: Track = try xmlParser["Track"].value()

			XCTAssertEqual(track0.id, 0)
			XCTAssertEqual(track0.name, "trackNameString")
			XCTAssertEqual(track0.shortName, "tns.")
			XCTAssertEqual(track0.color, [1, 2, 3])

			XCTAssertEqual(track0.systemsDefautLayout, 3)
			XCTAssertEqual(track0.systemsLayout, 1)

			XCTAssertEqual(track0.palmMute, 0.5)
			XCTAssertEqual(track0.playingStyle, .defaultStyle)
			XCTAssertEqual(track0.letRingThroughout, true)
			XCTAssertEqual(track0.autoBrush, false)
			XCTAssertEqual(track0.useOneChannelPerString, false)

		} catch {
			XCTFail("\(error)")
		}
	}

	func testIds() {
		let xmlParser0 = SWXMLHash.parse(testTrack0)
		let xmlParser1 = SWXMLHash.parse(testTrack1)
		let xmlParser2 = SWXMLHash.parse(testTrack2)

		do {
			let track0: Track = try xmlParser0["Track"].value()
			XCTAssertEqual(track0.id, 0)
			let track1: Track = try xmlParser1["Track"].value()
			XCTAssertEqual(track1.id, 1)
			let track2: Track = try xmlParser2["Track"].value()
			XCTAssertEqual(track2.id, 2)
		} catch {
			XCTFail("\(error)")
		}
	}
}

//
//	TrackTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2021-04-01.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

let testTrack0 = track0Open + testTrackBody + trackClose
let testTrack1 = track1Open + testTrackBody + trackClose
let testTrack2 = track2Open + testTrackBody + trackClose

/// GuitarPro has a concept of a Track. This is part of a song, which roughly corresponds to a MusicNotation.Part.
@Suite final class TrackTests {
	@Test func parse() async throws {
		let xmlParser = XMLHash.parse(testTrack0)

		let track0: Track = try xmlParser[Track.key].value()

		#expect(track0.id == 0)
		#expect(track0.name == "trackNameString")
		#expect(track0.shortName == "tns.")
		#expect(track0.color == [1, 2, 3])

		#expect(track0.systemsDefautLayout == 3)
		#expect(track0.systemsLayout == [1])

		#expect(track0.palmMute == 0.5)
		#expect(track0.playingStyle == .defaultStyle)
		#expect(track0.letRingThroughout == true)
		#expect(track0.autoBrush == false)
		#expect(track0.useOneChannelPerString == false)
	}

	@Test func ids() async throws {
		let xmlParser0 = XMLHash.parse(testTrack0)
		let xmlParser1 = XMLHash.parse(testTrack1)
		let xmlParser2 = XMLHash.parse(testTrack2)

		let track0: Track = try xmlParser0[Track.key].value()
		#expect(track0.id == 0)
		let track1: Track = try xmlParser1[Track.key].value()
		#expect(track1.id == 1)
		let track2: Track = try xmlParser2[Track.key].value()
		#expect(track2.id == 2)
	}
}

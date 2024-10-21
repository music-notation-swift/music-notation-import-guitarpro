//
//	MIDIConnectionTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-19.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class MIDIConnectionTests {
	@Test func parseArray() async throws {
		let xmlString = """
      <MidiConnection>
        <Port>0</Port>
        <PrimaryChannel>2</PrimaryChannel>
        <SecondaryChannel>3</SecondaryChannel>
        <ForeOneChannelPerString>false</ForeOneChannelPerString>
      </MidiConnection>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let midiConnection: MIDIConnection = try xmlParser["MidiConnection"].value()
		#expect(midiConnection.port == 0)
	}
}

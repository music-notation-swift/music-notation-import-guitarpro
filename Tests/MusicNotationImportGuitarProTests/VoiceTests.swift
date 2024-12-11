//
//	VoiceTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-20.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class VoiceTests {
	@Test func parseArray() async throws {
		let xmlString = """
  <Voices>
    <Voice id="0">
      <Beats>0</Beats>
    </Voice>
    <Voice id="1">
      <Beats>1</Beats>
    </Voice>
    <Voice id="2">
      <Beats>1</Beats>
    </Voice>
    <Voice id="3">
      <Beats>1</Beats>
    </Voice>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let voices: [Voice] = try xmlParser["Voices"][Voice.nodeKey].value()
		#expect(voices.count == 4)
	}

	@Test func parseEmptyArray() async throws {
		let xmlString = "<Voices></Voices>"
		let xmlParser = XMLHash.parse(xmlString)

		let voices: [Voice]? = try xmlParser["Voices"]["Voices"].value()
		#expect(voices == nil)
	}
}

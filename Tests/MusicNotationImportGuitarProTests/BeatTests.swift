//
//	BeatTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-19.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class BeatTests {
	@Test func parseArray() async throws {
		let xmlString = """
  <Beats>
    <Beat id="0">
      <Dynamic>MF</Dynamic>
      <Rhythm ref="0" />
      <TransposedPitchStemOrientation>Downward</TransposedPitchStemOrientation>
      <ConcertPitchStemOrientation>Undefined</ConcertPitchStemOrientation>
      <Properties>
        <Property name="PrimaryPickupVolume">
          <Float>0.500000</Float>
        </Property>
        <Property name="PrimaryPickupTone">
          <Float>0.500000</Float>
        </Property>
      </Properties>
    </Beat>
    <Beat id="1">
      <Dynamic>MF</Dynamic>
      <Rhythm ref="0" />
      <TransposedPitchStemOrientation>Downward</TransposedPitchStemOrientation>
      <ConcertPitchStemOrientation>Undefined</ConcertPitchStemOrientation>
      <Properties>
        <Property name="PrimaryPickupVolume">
          <Float>0.500000</Float>
        </Property>
        <Property name="PrimaryPickupTone">
          <Float>0.500000</Float>
        </Property>
      </Properties>
    </Beat>
  </Beats>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let beats: [Beat] = try xmlParser["Beats"]["Beat"].value()
		#expect(beats.count == 2)
		#expect(beats[0].id == 0)
		#expect(beats[1].id == 1)
		#expect(beats[0].dynamic == "MF")
		#expect(beats[0].properties.count == 2)
		#expect(beats[0].extraProperties == nil)
	}

	@Test func parseEmptyArray() async throws {
		let xmlString = "<Beats></Beats>"
		let xmlParser = XMLHash.parse(xmlString)

		let beats: [Beat]? = try xmlParser["Beats"]["Beat"].value()
		#expect(beats == nil)
	}
}

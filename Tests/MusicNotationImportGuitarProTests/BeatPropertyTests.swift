//
//	BeatPropertyTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-20.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class BeatPropertyTests {
	@Test func parseArray() async throws {
		let xmlString = """
      <Properties>
        <Property name="PrimaryPickupVolume">
          <Float>0.500000</Float>
        </Property>
        <Property name="PrimaryPickupTone">
          <Float>0.600000</Float>
        </Property>
        <Property name="Brush">
          <Direction>Up</Direction>
        </Property>
      </Properties>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let beatProperties: [BeatProperty] = try xmlParser["Properties"]["Property"].value()
		guard case let .primaryPickupVolume(volume) = beatProperties[0] else { throw BeatPropertyError.caseLetError }
		guard case let .primaryPickupTone(tone) = beatProperties[1] else { throw BeatPropertyError.caseLetError }
		guard case let .brush(direction) = beatProperties[2] else { throw BeatPropertyError.caseLetError }

		#expect(beatProperties.count == 3)
		#expect(volume == 0.5)
		#expect(tone == 0.6)
		#expect(direction == .up)
	}

	@Test func parseBarArrayElement() async throws {
		let xmlString = """
  <Properties>
    <Property name="BadProperty">
      <String>bad string</String>
    </Property>
  </Properties>
  """
		let xmlParser = XMLHash.parse(xmlString)

		#expect(throws: BeatPropertyParseError.self) {
			let _: [BeatProperty]? = try xmlParser["Properties"]["Property"].value()
		}
	}

	@Test func parseEmptyArray() async throws {
		let xmlString = "<Properties></Properties>"
		let xmlParser = XMLHash.parse(xmlString)

		let beatProperties: [BeatProperty]? = try xmlParser["Beats"]["Beat"].value()
		#expect(beatProperties == nil)
	}
}

enum BeatPropertyError: Error {
	case caseLetError
}

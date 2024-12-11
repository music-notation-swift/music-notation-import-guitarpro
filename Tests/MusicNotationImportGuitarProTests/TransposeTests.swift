//
//	TransposeTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-19.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class TransposeTests {
	@Test func parseArray() async throws {
		let xmlString = """
      <Transpose>
        <Chromatic>0</Chromatic>
        <Octave>0</Octave>
      </Transpose>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let transpose: Transpose = try xmlParser[Transpose.nodeKey].value()
		#expect(transpose.chromatic == false)
		#expect(transpose.octave == 0)
	}
}

//
//	NoteTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-19.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class NoteTests {
	@Test func parseArray() async throws {
		let xmlString = """
  <Notes>
    <Note id="0">
      <Tie origin="true" destination="false" />
      <InstrumentArticulation>0</InstrumentArticulation>
      <Properties>
        <Property name="ConcertPitch">
          <Pitch>
            <Step>E</Step>
            <Accidental></Accidental>
            <Octave>3</Octave>
          </Pitch>
        </Property>
        <Property name="Fret">
          <Fret>-24</Fret>
        </Property>
        <Property name="Midi">
          <Number>40</Number>
        </Property>
        <Property name="String">
          <String>5</String>
        </Property>
        <Property name="TransposedPitch">
          <Pitch>
            <Step>E</Step>
            <Accidental></Accidental>
            <Octave>3</Octave>
          </Pitch>
        </Property>
      </Properties>
    </Note>
    <Note id="1">
      <Tie origin="true" destination="true" />
      <InstrumentArticulation>0</InstrumentArticulation>
      <Properties>
        <Property name="ConcertPitch">
          <Pitch>
            <Step>E</Step>
            <Accidental></Accidental>
            <Octave>3</Octave>
          </Pitch>
        </Property>
        <Property name="Fret">
          <Fret>-24</Fret>
        </Property>
        <Property name="Midi">
          <Number>40</Number>
        </Property>
        <Property name="String">
          <String>5</String>
        </Property>
        <Property name="TransposedPitch">
          <Pitch>
            <Step>E</Step>
            <Accidental></Accidental>
            <Octave>3</Octave>
          </Pitch>
        </Property>
      </Properties>
    </Note>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let notes: [Note] = try xmlParser["Notes"][Note.key].value()
		#expect(notes.count == 2)
	}

	@Test func parseEmptyArray() async throws {
		let xmlString = "<Notes></Notes>"
		let xmlParser = XMLHash.parse(xmlString)

		let notes: [Note]? = try xmlParser["Notes"][Note.key].value()
		#expect(notes == nil)
	}
}

//
//	RhythmTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-19.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class RhythmTests {
	@Test func parseArray() async throws {
		let xmlString = """
  <Rhythms>
   <Rhythm id="0">
    <NoteValue>Whole</NoteValue>
   </Rhythm>
   <Rhythm id="1">
    <NoteValue>Eighth</NoteValue>
   </Rhythm>
   <Rhythm id="2">
    <NoteValue>16th</NoteValue>
   </Rhythm>
   <Rhythm id="3">
    <NoteValue>Half</NoteValue>
   </Rhythm>
   <Rhythm id="4">
    <NoteValue>Quarter</NoteValue>
   </Rhythm>
   <Rhythm id="5">
    <NoteValue>16th</NoteValue>
    <PrimaryTuplet num="6" den="4" />
   </Rhythm>
   <Rhythm id="6">
    <NoteValue>16th</NoteValue>
    <PrimaryTuplet num="3" den="2" />
   </Rhythm>
   <Rhythm id="7">
    <NoteValue>Quarter</NoteValue>
    <AugmentationDot count="1" />
   </Rhythm>
   <Rhythm id="8">
    <NoteValue>Quarter</NoteValue>
    <PrimaryTuplet num="3" den="2" />
   </Rhythm>
   <Rhythm id="9">
    <NoteValue>Eighth</NoteValue>
    <PrimaryTuplet num="3" den="2" />
   </Rhythm>
   <Rhythm id="10">
    <NoteValue>Eighth</NoteValue>
    <AugmentationDot count="1" />
   <PrimaryTuplet num="3" den="2" />
   </Rhythm>
   <Rhythm id="11">
    <NoteValue>Eighth</NoteValue>
    <AugmentationDot count="1" />
   </Rhythm>
   <Rhythm id="12">
    <NoteValue>Half</NoteValue>
    <AugmentationDot count="1" />
   </Rhythm>
   <Rhythm id="13">
    <NoteValue>Half</NoteValue>
    <AugmentationDot count="2" />
   </Rhythm>
   <Rhythm id="14">
    <NoteValue>32nd</NoteValue>
   </Rhythm>
   <Rhythm id="15">
    <NoteValue>32nd</NoteValue>
    <AugmentationDot count="1" />
   </Rhythm>
  </Rhythms>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let rhythms: [Rhythm] = try xmlParser["Rhythms"]["Rhythm"].value()
		#expect(rhythms.count == 16)
		#expect(rhythms[0].id == 0)
		#expect(rhythms[15].id == 15)
	}

	@Test func parseEmptyArray() async throws {
		let xmlString = "<Rhythms></Rhythms>"
		let xmlParser = XMLHash.parse(xmlString)

		let rhythms: [Rhythm]? = try xmlParser["Rhythms"]["Rhythm"].value()
		#expect(rhythms == nil)
	}
}

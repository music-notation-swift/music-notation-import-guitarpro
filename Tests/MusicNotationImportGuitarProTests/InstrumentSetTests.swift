//
//	InstrumentSetTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-19.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class InstrumentSetTests {
	@Test func parseArray() async throws {
		let xmlString = """
      <InstrumentSet>
        <Name>Electric Piano</Name>
        <Type>electricPiano</Type>
        <LineCount>5</LineCount>
        <Elements>
          <Element>
            <Name>Pitched</Name>
            <Type>pitched</Type>
            <SoundbankName></SoundbankName>
            <Articulations>
              <Articulation>
                <Name></Name>
                <StaffLine>0</StaffLine>
                <Noteheads>noteheadBlack noteheadHalf noteheadWhole</Noteheads>
                <TechniquePlacement>outside</TechniquePlacement>
                <TechniqueSymbol></TechniqueSymbol>
                <InputMidiNumbers></InputMidiNumbers>
                <OutputRSESound></OutputRSESound>
                <OutputMidiNumber>0</OutputMidiNumber>
              </Articulation>
            </Articulations>
          </Element>
        </Elements>
      </InstrumentSet>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let instrumentSet: InstrumentSet = try xmlParser["InstrumentSet"].value()
		#expect(instrumentSet.name == "Electric Piano")
//		#expect(instrumentSet.elements.count == 1)
	}
}

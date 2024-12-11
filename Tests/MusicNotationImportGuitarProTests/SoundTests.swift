//
//	SoundTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-19.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class SoundTests {
	@Test func parseArray() async throws {
		let xmlString = """
      <Sounds>
        <Sound>
          <Name>Geddy Lee Vocals - Xanadu</Name>
          <Label>Geddy Lee</Label>
          <Path>Orchestra/Keyboard/Electric Piano</Path>
          <Role>User</Role>
          <MIDI>
            <LSB>0</LSB>
            <MSB>0</MSB>
            <Program>53</Program>
          </MIDI>
          <RSE>
            <SoundbankPatch>MarkI-EPiano</SoundbankPatch>
            <ElementsSettings></ElementsSettings>
            <Pickups>
              <OverloudPosition>0</OverloudPosition>
              <Volumes>1 1</Volumes>
              <Tones>1 1</Tones>
            </Pickups>
            <EffectChain>
              <Effect id="M08_GraphicEQ10Band">
                <Parameters>1 1 0.25 0.5 0.5 0.5 0.5 0.346939 0.612245 0.632653 0.5 0.693878 0.5</Parameters>
              </Effect>
              <Effect id="M13_ModulationDigitalChorus">
                <Parameters>0.28 0.5 0.5 0.64</Parameters>
              </Effect>
              <Effect id="M07_DynamicClassicDynamic">
                <Parameters>0.77 0.5 0.3209</Parameters>
              </Effect>
              <Effect id="M02_StudioReverbHallSmallTheater">
                <Parameters>1 0.43 0.27 0.37 0.6</Parameters>
              </Effect>
            </EffectChain>
          </RSE>
        </Sound>
      </Sounds>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let sound: [Sound] = try xmlParser["Sounds"][Sound.nodeKey].value()
		#expect(sound.count == 1)
	}

	@Test func parseEmptyArray() async throws {
		let xmlString = "<Sounds></Sounds>"
		let xmlParser = XMLHash.parse(xmlString)

		let sounds: Sound? = try xmlParser["Sounds"][Sound.nodeKey].value()
		#expect(sounds == nil)
	}
}

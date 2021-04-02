//
//	TrackTests.swift
//	music-notation-import-tests
//
//	Created by Steven Woolgar on 2021-04-01.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import XCTest
import SWXMLHash
@testable import MusicNotationImportGuitarPro

let testTrack1 = """
	<Track id="0">
		<Name><![CDATA[trackNameString]]></Name>
		<ShortName><![CDATA[tns.]]></ShortName>
		<Color>1 2 3</Color>

		<SystemsDefautLayout>3</SystemsDefautLayout>
		<SystemsLayout>1</SystemsLayout>
		<LetRingThroughout />

		<PalmMute>0.5</PalmMute>
		<PlayingStyle>Default</PlayingStyle>

		<IconId>10</IconId>

		<InstrumentSet>
			<Name>Acoustic Piano</Name>
			<Type>acousticPiano</Type>
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

		<Transpose>
			<Chromatic>0</Chromatic>
			<Octave>0</Octave>
		</Transpose>

		<RSE>
			<ChannelStrip version="E56">
			<Parameters>0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 1 0.5 0.5 0.795 0.5 0.5 0.5</Parameters>
			</ChannelStrip>
		</RSE>

		<ForcedSound>-1</ForcedSound>
		<Sounds>
			<Sound>
				<Name><![CDATA[Acoustic Piano]]></Name>
				<Label><![CDATA[Acoustic Piano]]></Label>
				<Path>Orchestra/Keyboard/Acoustic Piano</Path>
				<Role>Factory</Role>
				<MIDI>
					<LSB>0</LSB>
					<MSB>0</MSB>
					<Program>0</Program>
				</MIDI>
				<RSE>
					<SoundbankPatch>German-APiano</SoundbankPatch>
					<Pickups>
						<OverloudPosition>0</OverloudPosition>
						<Volumes>1 1</Volumes>
						<Tones>1 1</Tones>
					</Pickups>
					<EffectChain>
						<Effect id="M08_GraphicEQ10Band">
							<Parameters>1 0 0.75 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5</Parameters>
						</Effect>
						<Effect />
						<Effect />
						<Effect />
						<Effect />
						<Effect />
					</EffectChain>
				</RSE>
			</Sound>
		</Sounds>

		<MidiConnection>
			<Port>0</Port>
			<PrimaryChannel>0</PrimaryChannel>
			<SecondaryChannel>1</SecondaryChannel>
			<ForeOneChannelPerString>false</ForeOneChannelPerString>
		</MidiConnection>

		<PlaybackState>Default</PlaybackState>
		<AudioEngineState>RSE</AudioEngineState>

		<Lyrics dispatched="true">
			<Line>
			<Text><![CDATA[]]></Text>
			<Offset>0</Offset>
			</Line>
			<Line>
			<Text><![CDATA[]]></Text>
			<Offset>0</Offset>
			</Line>
			<Line>
			<Text><![CDATA[]]></Text>
			<Offset>0</Offset>
			</Line>
			<Line>
			<Text><![CDATA[]]></Text>
			<Offset>0</Offset>
			</Line>
			<Line>
			<Text><![CDATA[]]></Text>
			<Offset>0</Offset>
			</Line>
		</Lyrics>

		<Staves>
			<Staff>
				<Properties>
					<Property name="CapoFret">
						<Fret>0</Fret>
					</Property>
					<Property name="FretCount">
						<Number>24</Number>
					</Property>
					<Property name="PartialCapoFret">
						<Fret>0</Fret>
					</Property>
					<Property name="PartialCapoStringFlags">
						<Bitset>000000</Bitset>
					</Property>
					<Property name="Tuning">
						<Pitches>40 45 50 55 59 64</Pitches>
						<Flat></Flat>
						<Instrument>Guitar</Instrument>
						<Label><![CDATA[]]></Label>
						<LabelVisible>true</LabelVisible>
					</Property>
					<Property name="ChordCollection">
						<Items/>
					</Property>
					<Property name="ChordWorkingSet">
						<Items/>
					</Property>
					<Property name="DiagramCollection">
						<Items/>
					</Property>
					<Property name="DiagramWorkingSet">
						<Items/>
					</Property>
					<Property name="TuningFlat">
						<Enable />
					</Property>
					<Name><![CDATA[Standard]]></Name>
				</Properties>
			</Staff>
		</Staves>

		<Automations>
			<Automation>
				<Type>Sound</Type>
				<Linear>false</Linear>
				<Bar>0</Bar>
				<Position>0</Position>
				<Visible>true</Visible>
				<Value><![CDATA[Orchestra/Keyboard/Acoustic Piano;Acoustic Piano;Factory]]></Value>
			</Automation>
		</Automations>
	</Track>
"""

/// GuitarPro 7 has a concept of a Track. This is part of a song, which roughly corresponds to a MusicNotation.Part.
class TrackTests: XCTestCase {
	func testDescription() {
		let xmlParser = SWXMLHash.parse(testTrack1)

		do {
			let track1: Track = try xmlParser["Track"].value()
			XCTAssertEqual(track1.name, "trackNameString")
			XCTAssertEqual(track1.shortName, "tns.")
			XCTAssertEqual(track1.color, [1, 2, 3])

			XCTAssertEqual(track1.systemsDefautLayout, 3)
			XCTAssertEqual(track1.systemsLayout, 1)

			XCTAssertEqual(track1.palmMute, 0.5)
			XCTAssertEqual(track1.playingStyle, .defaultStyle)
			XCTAssertEqual(track1.letRingThroughout, true)
			XCTAssertEqual(track1.autoBrush, false)
			XCTAssertEqual(track1.useOneChannelPerString, false)

		} catch {
			XCTFail("\(error)")
		}
	}
}

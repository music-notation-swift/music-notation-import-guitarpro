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

let track0Open = "<Track id=\"0\">\n"
let track1Open = "<Track id=\"1\">\n"
let track2Open = "<Track id=\"2\">\n"
let trackClose = "\n</Track>"
let track0Information = """
	<Name><![CDATA[trackNameString]]></Name>
	<ShortName><![CDATA[tns.]]></ShortName>
	<Color>1 2 3</Color>
	<IconId>10</IconId>
"""
let track0MusicNotation = """
	<SystemsDefautLayout>3</SystemsDefautLayout>
	<SystemsLayout>1</SystemsLayout>

"""
let track0Interpretation = """
	<LetRingThroughout />
	<PalmMute>0.5</PalmMute>
	<PlayingStyle>Default</PlayingStyle>
"""
let track0InstrumentSet = """
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
"""
let track0Transpose = """

	<Transpose>
		<Chromatic>0</Chromatic>
		<Octave>0</Octave>
	</Transpose>
"""
let track0RSE = """

	<RSE>
		<ChannelStrip version="E56">
		<Parameters>0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 1 0.5 0.5 0.795 0.5 0.5 0.5</Parameters>
		</ChannelStrip>
	</RSE>
"""
let track0Sounds = """

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
"""
let track0MidiConnection = """

	<MidiConnection>
		<Port>0</Port>
		<PrimaryChannel>0</PrimaryChannel>
		<SecondaryChannel>1</SecondaryChannel>
		<ForeOneChannelPerString>false</ForeOneChannelPerString>
	</MidiConnection>
"""
let track0Audio = """

	<PlaybackState>Default</PlaybackState>
	<AudioEngineState>RSE</AudioEngineState>
"""
let track0Lyrics = """

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
"""
let track0Staves = """

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
"""
let track0Automations = """

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
"""

let testTrackBody = track0Information + track0MusicNotation + track0Interpretation +
					track0InstrumentSet + track0Transpose + track0RSE + track0Sounds + track0MidiConnection + track0Audio +
					track0Staves + track0Automations

let testTrack0 = track0Open + testTrackBody + trackClose
let testTrack1 = track1Open + testTrackBody + trackClose
let testTrack2 = track2Open + testTrackBody + trackClose

/// GuitarPro 7 has a concept of a Track. This is part of a song, which roughly corresponds to a MusicNotation.Part.
class TrackTests: XCTestCase {
	func testParse() {
		let xmlParser = SWXMLHash.parse(testTrack0)

		do {
			let track0: Track = try xmlParser["Track"].value()

			XCTAssertEqual(track0.id, 0)
			XCTAssertEqual(track0.name, "trackNameString")
			XCTAssertEqual(track0.shortName, "tns.")
			XCTAssertEqual(track0.color, [1, 2, 3])

			XCTAssertEqual(track0.systemsDefautLayout, 3)
			XCTAssertEqual(track0.systemsLayout, 1)

			XCTAssertEqual(track0.palmMute, 0.5)
			XCTAssertEqual(track0.playingStyle, .defaultStyle)
			XCTAssertEqual(track0.letRingThroughout, true)
			XCTAssertEqual(track0.autoBrush, false)
			XCTAssertEqual(track0.useOneChannelPerString, false)

		} catch {
			XCTFail("\(error)")
		}
	}

	func testIds() {
		let xmlParser0 = SWXMLHash.parse(testTrack0)
		let xmlParser1 = SWXMLHash.parse(testTrack1)
		let xmlParser2 = SWXMLHash.parse(testTrack2)

		do {
			let track0: Track = try xmlParser0["Track"].value()
			XCTAssertEqual(track0.id, 0)
			let track1: Track = try xmlParser1["Track"].value()
			XCTAssertEqual(track1.id, 1)
			let track2: Track = try xmlParser2["Track"].value()
			XCTAssertEqual(track2.id, 2)
		} catch {
			XCTFail("\(error)")
		}
	}
}

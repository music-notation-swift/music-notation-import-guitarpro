//
//	GuitarProInterchangeFormat.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// The root element of this is the `<GPIF>` element.
public struct GuitarProInterchangeFormat: XMLObjectDeserialization {
	public var version: Version
	public var revision: Revision
	public var encoding: String
	public var score: Score
	public var masterTrack: MasterTrack
	public var tracks: [Track]
	public var masterBars: [MasterBar]
	public var bars: [Bar]
	public var voices: [Voice]?
	public var beats: [Beat]?
	public var notes: [Note]?
	public var rhythms: [Rhythm]?

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try GuitarProInterchangeFormat(
			version: Version.withString(node["GPVersion"].value()),
			revision: node[Revision.nodeKey].value(),
			encoding: node["Encoding"].value(),
			score: node[Score.nodeKey].value(),
			masterTrack: node[MasterTrack.nodeKey].value(),
			tracks: node["Tracks"][Track.nodeKey].value(),
			masterBars: node["MasterBars"][MasterBar.nodeKey].value(),
			bars: node["Bars"][Bar.nodeKey].value(),
			voices: node["Voices"][Voice.nodeKey].value(),
			beats: node["Beats"][Beat.nodeKey].value(),
			notes: node["Notes"][Note.nodeKey].value(),
			rhythms: node["Rhythms"]["Rhythm"].value()
		)
	}
}

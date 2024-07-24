//
//	GuitarProInterchangeFormat.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

public struct GuitarProInterchangeFormat: XMLIndexerDeserializable {
	public var version: Int
	public var revision: Revision
	public var encoding: String
	public var score: Score
	public var masterTrack: MasterTrack
	public var tracks: [Track]
	public var masterBars: [MasterBar]
	public var bars: [Bar]
	public var voices: [Voice]
	public var beats: [Beat]
	public var notes: [Note]
	public var rhythms: [Rhythm]

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try GuitarProInterchangeFormat(
			version: node["GPVersion"].value(),
			revision: node["GPRevision"].value(),
			encoding: node["Encoding"].value(),
			score: node["Score"].value(),
			masterTrack: node["MasterTrack"].value(),
			tracks: node["Tracks"]["Track"].value(),
			masterBars: node["MasterBars"]["MasterBar"].value(),
			bars: node["Bars"]["Bar"].value(),
			voices: node["Voices"]["Voice"].value(),
			beats: node["Beats"]["Beat"].value(),
			notes: node["Notes"]["Note"].value(),
			rhythms: node["Rhythms"]["Rhythm"].value()
		)
	}
}

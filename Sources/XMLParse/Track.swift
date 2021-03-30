//
//	Track.swift
//	music-notation-import
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2020-2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

public struct Track: XMLIndexerDeserializable {
	var id: Int

	public var name: String
	public var shortName: String
	public var color: String
	public var systemsDefautLayout: Int

	public var systemsLayout: String
	public var palmMute: Bool
	public var playingStyle: String

	public var iconId: Int
	public var forcedSound: Int
	public var playbackState: String

	public var audioEngineState: String
	public var staves: [Staff]
	public var automations: [Automation]

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Track(
			id: node.value(ofAttribute: "id"),
			name: node["Name"].value(),
			shortName: node["ShortName"].value(),
			color: node["Color"].value(),
			systemsDefautLayout: node["SystemsDefautLayout"].value(),
			systemsLayout: node["SystemsLayout"].value(),
			palmMute: node["PalmMute"].value(),
			playingStyle: node["PlayingStyle"].value(),
			iconId: node["IconId"].value(),
			forcedSound: node["ForcedSound"].value(),
			playbackState: node["PlaybackState"].value(),
			audioEngineState: node["AudioEngineState"].value(),
			staves: node["Staves"]["Staff"].value(),
			automations: node["Automations"]["Automation"].value()
		)
	}
}

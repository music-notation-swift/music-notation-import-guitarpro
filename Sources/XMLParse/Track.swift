//
//	Track.swift
//	music-notation-import
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

public enum TrackErrorPlayingStyleError: Error { case unsupportedPlayingStyle(String) }

public enum PlayingStyle: String {
	case defaultStyle = "Default"
	case stringedPick = "StringedPick"
	case stringedFinger = "StringedFinger"
	case stringedFingerPicking = "StringedFingerPicking"
	case bassSlap = "BassSlap"

	static func withString(_ string: String) throws -> Self {
		switch string {
		case defaultStyle.rawValue:
			return defaultStyle
		case stringedPick.rawValue:
			return stringedPick
		case stringedFinger.rawValue:
			return stringedFinger
		case stringedFingerPicking.rawValue:
			return stringedFingerPicking
		case bassSlap.rawValue:
			return defaultStyle
		default:
			throw TrackErrorPlayingStyleError.unsupportedPlayingStyle(string)
		}
	}
}

public struct Track: XMLIndexerDeserializable {
	var id: Int

	public var name: String
	public var shortName: String
	public var color: [Int]
	public var iconId: Int

	public var systemsDefautLayout: Int
	public var systemsLayout: [Int]

	public var playingStyle: PlayingStyle
	public var palmMute: Double					// 0-1 (percent)
	public var autoAccentuation: Double?		// 0-1 (percent)
	public var letRingThroughout: Bool			// Shows as "Auto let ring" in the user interface
	public var autoBrush: Bool
	public var useOneChannelPerString: Bool		// Shows as "Stringed" in the user interface

	public var forcedSound: Int
	public var playbackState: String
	public var audioEngineState: String

	public var staves: [Staff]
	public var automations: [Automation]

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		let colors: String = try node["Color"].value()
		let colorsArray = colors.split(separator: " ")
		let layouts: String = try node["SystemsLayout"].value()
		let layoutsArray = layouts.split(separator: " ")
		let id: Int = try node.value(ofAttribute: "id")
		print("Track(id=\(id))")

		return try Track(
			id: node.value(ofAttribute: "id"),
			name: node["Name"].value(),
			shortName: node["ShortName"].value(),
			color: colorsArray.compactMap { Int($0) },
			iconId: node["IconId"].value(),
			systemsDefautLayout: node["SystemsDefautLayout"].value(),
			systemsLayout: layoutsArray.compactMap { Int($0) },
			playingStyle: PlayingStyle.withString(node["PlayingStyle"].value()),
			palmMute: node["PalmMute"].value(),
			autoAccentuation: node["AutoAccentuation"].value(),
			letRingThroughout: (node["LetRingThroughout"].element != nil) ? true : false,
			autoBrush: (node["AutoBrush"].element != nil) ? true : false,
			useOneChannelPerString: (node["UseOneChannelPerString"].element != nil) ? true : false,
			forcedSound: node["ForcedSound"].value(),
			playbackState: node["PlaybackState"].value(),
			audioEngineState: node["AudioEngineState"].value(),
			staves: node["Staves"]["Staff"].value(),
			automations: node["Automations"]["Automation"].value()
		)
	}
}

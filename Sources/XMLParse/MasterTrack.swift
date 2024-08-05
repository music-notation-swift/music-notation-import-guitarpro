//
//	MasterTrack.swift
//	music-notation-import
//
//	Created by Steven Woolgar on 2021-03-30.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import SWXMLHash

public struct MasterTrack: XMLObjectDeserialization {
	var tracks: String

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try MasterTrack(
			tracks: node["Tracks"].value()
		)
	}
}

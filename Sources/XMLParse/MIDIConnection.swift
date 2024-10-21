//
//	MIDIConnection.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <MidiConnection>
//  <Port>0</Port>
//  <PrimaryChannel>2</PrimaryChannel>
//  <SecondaryChannel>3</SecondaryChannel>
//  <ForeOneChannelPerString>false</ForeOneChannelPerString>
// </MidiConnection>

public struct MIDIConnection: XMLObjectDeserialization {
	var port: Int
	var primaryChannel: Int
	var secondaryChannel: Int
	var forceOneChannelPerString: Bool

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try MIDIConnection(
			port: node["Port"].value(),
			primaryChannel: node["PrimaryChannel"].value(),
			secondaryChannel: node["SecondaryChannel"].value(),
			forceOneChannelPerString: node["ForeOneChannelPerString"].value()
		)
	}
}

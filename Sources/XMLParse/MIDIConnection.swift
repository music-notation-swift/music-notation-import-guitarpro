//
//	MIDIConnection.swift
//	music-notation-import
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

public struct MIDIConnection: XMLIndexerDeserializable {
	var port: Int

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try MIDIConnection(
			port: node["Port"].value()
		)
	}
}

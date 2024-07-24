//
//	MasterBar.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-10.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

/// NB: As per the XML file, order of masterbars are important.

public struct MasterBar: XMLIndexerDeserializable {
	var key: Key
	var timeSignature: TimeSignature

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try MasterBar(
			key: node["Key"].value(),
			timeSignature: node["Time"].value()
		)
	}
}

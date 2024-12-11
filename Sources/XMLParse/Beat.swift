//
//	Beat.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <Beat id="0">
//   <Dynamic>MF</Dynamic>
//   <Rhythm ref="0" />
//   <TransposedPitchStemOrientation>Downward</TransposedPitchStemOrientation>
//   <ConcertPitchStemOrientation>Undefined</ConcertPitchStemOrientation>
//   <Properties>
//	 <Property name="PrimaryPickupVolume">
//	   <Float>0.500000</Float>
//	 </Property>
//	 <Property name="PrimaryPickupTone">
//	   <Float>0.500000</Float>
//	 </Property>
//   </Properties>
// </Beat>

public struct Beat: XMLObjectDeserialization {
	static let nodeKey = "Beat"
	var id: Int
	var dynamic: String
	var rhythm: Int
	var transposedPitchStemOrientation: String
	var concertPitchStemOrientation: String
	var properties: [BeatProperty]
	var extraProperties: [ExtraProperty]?

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Beat(
			id: node.value(ofAttribute: "id"),
			dynamic: node["Dynamic"].value(),
			rhythm: node["Rhythm"].value(ofAttribute: "ref"),
			transposedPitchStemOrientation: node["TransposedPitchStemOrientation"].value(),
			concertPitchStemOrientation: node["ConcertPitchStemOrientation"].value(),
			properties: node["Properties"][BeatProperty.nodeKey].value(),
			extraProperties: node["XProperties"]["XProperty"].value()
		)
	}
}

//
//	Automation.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-10.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <Automations>
//   <Automation>
//	   <Type>DSPParam_11</Type>
//	   <Linear>false</Linear>
//	   <Bar>0</Bar>
//	   <Position>0</Position>
//	   <Visible>true</Visible>
//	   <Value>0.5</Value>
//   </Automation>
//  <Automation>
//	  <Type>DSPParam_12</Type>
//	  <Linear>false</Linear>
//	  <Bar>0</Bar>
//	  <Position>0</Position>
//	  <Visible>true</Visible>
//	<Value>0.99</Value>
//  </Automation>
// </Automations>

public struct Automation: XMLIndexerDeserializable {
	var type: String
	var linear: Bool
	var bar: Int
	var position: Float
	var visible: Bool
	var value: [Float]

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		let values: String = try node["Value"].value()
		let valuesArray = values.split(separator: " ")

		return try Automation(
			type: node["Type"].value(),
			linear: node["Linear"].value(),
			bar: node["Bar"].value(),
			position: node["Position"].value(),
			visible: node["Visible"].value(),
			value: valuesArray.compactMap { Float($0) }
		)
	}
}

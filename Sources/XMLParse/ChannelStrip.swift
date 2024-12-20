//
//	ChannelStrip.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <ChannelStrip version="E56">
//  <Parameters>0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0 0.5 0.5 0.99 0.5 0.5 0.5</Parameters>
//  <Automations>
//	  <Automation>
//	    <Type>DSPParam_11</Type>
//	    <Linear>false</Linear>
//	    <Bar>0</Bar>
//	    <Position>0</Position>
//	    <Visible>true</Visible>
//	    <Value>0.5</Value>
//	  </Automation>
//	  <Automation>
//	    <Type>DSPParam_12</Type>
//	    <Linear>false</Linear>
//	    <Bar>0</Bar>
//	    <Position>0</Position>
//	    <Visible>true</Visible>
//	    <Value>0.99</Value>
//	  </Automation>
//  </Automations>
// </ChannelStrip>

public struct ChannelStrip: XMLObjectDeserialization {
	static let nodeKey = "ChannelStrip"
	public var parameters: String
	public var automations: [Automation]?

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try ChannelStrip(
			parameters: node["Parameters"].value(),
			automations: node["Automations"][Automation.nodeKey].value()
		)
	}
}

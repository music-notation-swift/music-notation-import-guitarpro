//
//	MasterTrack.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-03-30.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import SWXMLHash

//<MasterTrack>
//  <Tracks>0 1 2 3 4 5</Tracks>
//  <Automations>
//	  <Automation>
//	    <Type>Tempo</Type>
//	    <Linear>false</Linear>
//	    <Bar>0</Bar>
//	    <Position>0</Position>
//	    <Visible>true</Visible>
//	    <Value>160 2</Value>
//	  </Automation>
//  </Automations>
//  <RSE>
//	  <Master>
//	    <Effect id="M06_DynamicAnalogDynamic">
//		  <Parameters>0 0 0.8 0 0.4 0.6 0.5 0.5</Parameters>
//	    </Effect>
//	    <Effect id="M03_StudioReverbRoomStudioA">
//		  <ByPass />
//		  <Parameters>0 0 0 0 0</Parameters>
//	    </Effect>
//	    <Effect id="M08_GraphicEQ10Band">
//	      <Parameters>0 0 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5</Parameters>
//	    </Effect>
//	    <Effect id="I01_VolumeAndPan">
//		  <Parameters>0.76 0.5</Parameters>
//		  <Automations>
//		    <Automation>
//		 	  <Type>DSPParam_00</Type>
//			  <Linear>false</Linear>
//			  <Bar>0</Bar>
//			  <Position>0</Position>
//			  <Visible>true</Visible>
//			  <Value>0.76</Value>
//		    </Automation>
//		    <Automation>
//		 	  <Type>DSPParam_01</Type>
//			  <Linear>false</Linear>
//			  <Bar>0</Bar>
//			  <Position>0</Position>
//			  <Visible>true</Visible>
//			  <Value>0.5</Value>
//		    </Automation>
//		  </Automations>
//	    </Effect>
//	  </Master>
//  </RSE>
//</MasterTrack>

public struct MasterTrack: XMLObjectDeserialization {
	static let nodeKey = "MasterTrack"
	var tracks: String

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try MasterTrack(
			tracks: node["Tracks"].value()
		)
	}
}

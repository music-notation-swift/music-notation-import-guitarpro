//
//	ChannelStripTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-19.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class ChannelStripTests {
	@Test func parseArray() async throws {
		let xmlString = """
  <ChannelStrip version="E56">
    <Parameters>0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0 0.5 0.5 0.99 0.5 0.5 0.5</Parameters>
    <Automations>
      <Automation>
        <Type>DSPParam_11</Type>
        <Linear>false</Linear>
        <Bar>0</Bar>
        <Position>0</Position>
        <Visible>true</Visible>
        <Value>0.5</Value>
      </Automation>
      <Automation>
        <Type>DSPParam_12</Type>
        <Linear>false</Linear>
        <Bar>0</Bar>
        <Position>0</Position>
        <Visible>true</Visible>
        <Value>0.99</Value>
      </Automation>
    </Automations>
  </ChannelStrip>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let channelStrip: ChannelStrip = try xmlParser[ChannelStrip.nodeKey].value()
		#expect(channelStrip.parameters != nil)
		#expect(channelStrip.automations != nil)
		#expect(channelStrip.automations?[0].type == "DSPParam_11")
		#expect(channelStrip.automations?[0].linear == false)
	}

	@Test func parseEmptyArray() async throws {
		let xmlString = """
  <ChannelStrip>
    <Parameters>0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0 0.5 0.5 0.99 0.5 0.5 0.5</Parameters>
  </ChannelStrip>
"""
		let xmlParser = XMLHash.parse(xmlString)

		let channelStrip: ChannelStrip = try xmlParser[ChannelStrip.nodeKey].value()
		#expect(channelStrip.parameters != nil)
		#expect(channelStrip.automations == nil)
	}
}

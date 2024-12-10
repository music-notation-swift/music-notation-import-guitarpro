//
//	Score.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-10.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

//	<Score>
//	  <Title>
//	<![CDATA[]]>
//	  </Title>
//	  <SubTitle>
//	<![CDATA[]]>
//	  </SubTitle>
//	  <Artist>
//	<![CDATA[]]>
//	  </Artist>
//	  <Album>
//	<![CDATA[]]>
//	  </Album>
//	  <Words>
//	<![CDATA[]]>
//	  </Words>
//	  <Music>
//	<![CDATA[]]>
//	  </Music>
//	  <WordsAndMusic>
//	<![CDATA[]]>
//	  </WordsAndMusic>
//	  <Copyright>
//	<![CDATA[]]>
//	  </Copyright>
//	  <Tabber>
//	<![CDATA[]]>
//	  </Tabber>
//	  <Instructions>
//	<![CDATA[]]>
//	  </Instructions>
//	  <Notices>
//	<![CDATA[]]>
//	  </Notices>
//	  <FirstPageHeader>
//	<![CDATA[<html><head><meta name="qrichtext" content="1" /><style type="text/css">p,
//		li { white-space: pre-wrap; }</style></head><body style=
//			" font-family:'Times New Roman';font-size:16pt; font-weight:400; font-style:normal;">
//			<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px;
//			margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Sans Serif';
//			font-size:10pt;"><span style=" font-family:'Times New Roman'; font-size:35pt;">%TITLE%</span></p>
//			<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px;
//			margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Sans Serif';
//			font-size:10pt;"><span style=" font-family:'Times New Roman'; font-size:16pt;">%SUBTITLE%</span></p>
//			<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px;
//			margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Sans Serif';
//			font-size:10pt;"><span style=" font-family:'Times New Roman'; font-size:16pt;">%ARTIST%</span></p>
//			<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px;
//			margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Sans Serif';
//			font-size:10pt;"><span style=" font-family:'Times New Roman'; font-size:16pt;">%ALBUM%</span></p>
//			<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px;
//			margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'Sans Serif';
//			font-size:10pt;"><span style=" font-family:'Times New Roman'; font-size:12pt;">%WORDS&MUSIC%</span></p>
//		</body></html>]]>
//	  </FirstPageHeader>
//	  <FirstPageFooter>
//	<![CDATA[<html><head><meta name="qrichtext" content="1" />
//		<style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style="
//		font-family:'Lucida Grande'; font-size:13pt; font-weight:400; font-style:normal;">
//		<p align="right" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px;
//		-qt-block-indent:0; text-indent:0px; font-family:'Times';
//		font-size:14pt;">Page %page%/%pages%</p></body></html>]]>
//	  </FirstPageFooter>
//	  <PageHeader>
//	<![CDATA[]]>
//	  </PageHeader>
//	  <PageFooter>
//	<![CDATA[<html><head><meta name="qrichtext" content="1" /><style type="text/css">p,
//		li { white-space: pre-wrap; }</style></head><body style=" font-family:'Lucida Grande';
//		font-size:13pt; font-weight:400; font-style:normal;"><p align="right" style=" margin-top:0px;
//		margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;
//		font-family:'Times'; font-size:14pt;">Page %page%/%pages%</p></body></html>]]>
//	  </PageFooter>
//	  <ScoreSystemsDefaultLayout>4</ScoreSystemsDefaultLayout>
//	  <ScoreSystemsLayout>4</ScoreSystemsLayout>
//	  <ScoreZoomPolicy>Value</ScoreZoomPolicy>
//	  <ScoreZoom>1</ScoreZoom>
//	  <MultiVoice>0&gt;</MultiVoice>
//	</Score>

public struct Score: XMLObjectDeserialization {
	static let key = "Score"

	var title: String
	var subtitle: String
	var artist: String
	var album: String
	var words: String
	var music: String
	var wordsAndMusic: String
	var copyright: String
	var tabber: String
	var instructions: String
	var notices: String
	var firstPageHeader: String
	var firstPageFooter: String
	var pageHeader: String
	var pageFooter: String
	var systemsDefaultLayout: Int
	var systemsLayout: Int
	var zoomPolicy: String
	var zoom: Float
	var multiVoice: String

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try Score(
			title: node["Title"].value(),
			subtitle: node["SubTitle"].value(),
			artist: node["Artist"].value(),
			album: node["Album"].value(),
			words: node["Words"].value(),
			music: node["Music"].value(),
			wordsAndMusic: node["WordsAndMusic"].value(),
			copyright: node["Copyright"].value(),
			tabber: node["Tabber"].value(),
			instructions: node["Instructions"].value(),
			notices: node["Notices"].value(),
			firstPageHeader: node["FirstPageFooter"].value(),
			firstPageFooter: node["FirstPageFooter"].value(),
			pageHeader: node["PageHeader"].value(),
			pageFooter: node["PageFooter"].value(),
			systemsDefaultLayout: node["ScoreSystemsDefaultLayout"].value(),
			systemsLayout: node["ScoreSystemsLayout"].value(),
			zoomPolicy: node["ScoreZoomPolicy"].value(),
			zoom: node["ScoreZoom"].value(),
			multiVoice: node["MultiVoice"].value()
		)
	}
}

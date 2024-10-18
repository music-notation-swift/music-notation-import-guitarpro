//
//	StaffProperty.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-10-14.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <Staff>
//  <Properties>
//	<Property name="CapoFret"><Fret>0</Fret></Property>
//	<Property name="FretCount"><Number>24</Number></Property>
//	<Property name="PartialCapoFret"><Fret>0</Fret></Property>
//	<Property name="PartialCapoStringFlags"><Bitset>000000</Bitset></Property>
//	<Property name="Tuning"><Pitches>40 45 50 55 59 64</Pitches><Flat></Flat><Instrument>Guitar</Instrument><Label><![CDATA[]]></Label><LabelVisible>true</LabelVisible></Property>
//	<Property name="ChordCollection"><Items /></Property>
//	<Property name="ChordWorkingSet"><Items /></Property>
//	<Property name="DiagramCollection"><Items /></Property>
//	<Property name="DiagramWorkingSet"><Items /></Property>
//	<Property name="TuningFlat"><Enable /></Property>
//	<Name><![CDATA[Standard]]></Name>
//  </Properties>
// </Staff>

public typealias TuningPitch = Int

public enum StaffPropertyParseError: Error {
	case unsupportedPropertyAttribute(String)
}

public struct StaffPropertyItem: XMLObjectDeserialization, Equatable {
	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		StaffPropertyItem()
	}
}

public enum StaffProperty: XMLObjectDeserialization {
	case capoFret(_ fret: Int)
	case fretCount(_ frets: Int)
	case partialCapoFret(Int)
	case partialCapoStringFlags(String)
	case tuning(pitches: [TuningPitch], flat: Int?, instrument: String, label: String, labelVisible: Bool)
	case chordCollection([StaffPropertyItem])
	case chordWorkingSet([StaffPropertyItem])
	case diagramCollection([StaffPropertyItem])
	case diagramWorkingSet([StaffPropertyItem])
	case tuningFlat(Bool)

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		let propertyAttribute: String = try node.value(ofAttribute: "name")

		switch propertyAttribute {
		case "CapoFret":
			return .capoFret(try node["Fret"].value())
		case "FretCount":
			return .fretCount(try node["Number"].value())
		case "PartialCapoFret":
			return .partialCapoFret(try node["Fret"].value())
		case "PartialCapoStringFlags":
			return .partialCapoStringFlags(try node["Bitset"].value())
		case "Tuning":
			let pitchesString: String = try node["Pitches"].value()
			let pitchesArray = pitchesString.split(separator: " ")
			let pitches = pitchesArray.compactMap { Int($0) }

			// <Flat></Flat> can be entirely missing.
			let flat: String? = try node["Flat"].value()

			return .tuning(
				pitches: pitches,
				flat: Int(flat ?? ""),
				instrument: try node["Instrument"].value(),
				label: try node["Label"].value(),
				labelVisible: try node["LabelVisible"].value())
		case "ChordCollection":
			return .chordCollection([])
		case "ChordWorkingSet":
			return .chordWorkingSet([])
		case "DiagramCollection":
			return .diagramCollection([])
		case "DiagramWorkingSet":
			return .diagramWorkingSet([])
		case "TuningFlat":
			return .tuningFlat(node["Enable"].element != nil)
		default:
			throw StaffPropertyParseError.unsupportedPropertyAttribute(propertyAttribute)
		}
	}
}

extension StaffProperty: Equatable {
	public static func == (lhs: StaffProperty, rhs: StaffProperty) -> Bool {
		switch (lhs, rhs) {
		case let (.capoFret(lhsFret), .capoFret(rhsFret)) where lhsFret == rhsFret:
			return true
		case let (.fretCount(lhsFrets), .fretCount(rhsFrets)) where lhsFrets == rhsFrets:
			return true
		case let (.partialCapoFret(lhsFret), .partialCapoFret(rhsFret)) where lhsFret == rhsFret:
			return true
		case let (.chordCollection(lhsItems), .chordCollection(rhsItems)) where lhsItems == rhsItems:
			return true
		case let (.chordWorkingSet(lhsItems), .chordWorkingSet(rhsItems)) where lhsItems == rhsItems:
			return true
		case let (.diagramCollection(lhsItems), .diagramCollection(rhsItems)) where lhsItems == rhsItems:
			return true
		case let (.diagramWorkingSet(lhsItems), .diagramWorkingSet(rhsItems)) where lhsItems == rhsItems:
			return true
		case let (.tuning(lhsPitches, lhsFlat, lhsInstrument, lhsLabel, lhsLabelVisible),
				  .tuning(rhsPitches, rhsFlat, rhsInstrument, rhsLabel, rhsLabelVisible))
				where lhsPitches == rhsPitches && lhsFlat == rhsFlat && lhsInstrument == rhsInstrument && lhsLabel == rhsLabel && lhsLabelVisible == rhsLabelVisible:
			return true
		case let (.tuningFlat(lhsFlat), .tuningFlat(rhsFlat)) where lhsFlat == rhsFlat:
			return true
		default:
			return false
		}
	}
}

/// Near Equality. In this case it means the enums are equal, but the associated values may not be
infix operator =~
extension StaffProperty {
	public static func =~ (lhs: StaffProperty, rhs: StaffProperty) -> Bool {
		switch (lhs, rhs) {
		case (.capoFret(_), .capoFret(_)):
			return true
		case (.fretCount(_), .fretCount(_)):
			return true
		case (.partialCapoFret(_), .partialCapoFret(_)):
			return true
		case (.chordCollection(_), .chordCollection(_)):
			return true
		case (.chordWorkingSet(_), .chordWorkingSet(_)):
			return true
		case (.diagramCollection(_), .diagramCollection(_)):
			return true
		case (.diagramWorkingSet(_), .diagramWorkingSet(_)):
			return true
		case (.tuning(_, _, _, _, _), .tuning(_, _, _, _, _)):
			return true
		case (.tuningFlat(_), .tuningFlat(_)):
			return true
		default:
			return false
		}
	}
}

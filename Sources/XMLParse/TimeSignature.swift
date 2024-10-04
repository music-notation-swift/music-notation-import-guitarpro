//
//	TimeSignature.swift
//	music-notation-import
//
//	Created by Steven Woolgar on 2021-02-23.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

// <Time>4/4</Time>
// <Time>7/8</Time>
// <Time>23/3</Time>

/// The time signature (also known as `meter signature`, `metre signature`, or `measure signature`) is a notational convention used
/// in Western musical notation to specify how many beats (pulses) are contained in each measure (bar), and which note value
/// is equivalent to a beat.
///
/// See `MusicNotation.TimeSignature` for a full explanation (or the README.md).

public enum TimeSignature: XMLObjectDeserialization {
	case simple(_ beatsPerBar: Int, _ beatUnit: Int)		// `2/4`, `3/4`, `4/4`, `common` and `cut-common`
	case compound(_ beatsPerBar: Int, _ beatUnit: Int)		// `9/8` and `12/8`
	case additive(_ beatsPerBar: [Int], _ beatUnit: Int)	// `3 + 2/8 + 3` (NB: I have seen `3/8 & 2/8`)
	case fractional(_ beatsPerBar: Float, _ beatUnit: Int)	// `2½/4`
	case complex(_ beatsPerBar: Int, _ beatUnit: Int)	// `3/10`, `5/24`

	// `5/4`, `7/8`, `11/16`, `8/8`
	func oddMeter() -> Bool {
		switch self {
		case let .simple(beatsPerBar, beatUnit), let .compound(beatsPerBar, beatUnit), let .complex(beatsPerBar, beatUnit):
			switch (beatsPerBar, beatUnit) {
			case (5, 4), (7, 4), (7, 8), (8, 8), (5, 8), (11, 8):
				return true
			case let (beatsPerBar, 16):
				return beatsPerBar % 2 != 0
			default:
				return false
			}
		default:
			return false
		}
	}

	public static func type(from: String) throws -> Self {
		var timeSignatureSubstring = from[...]
		guard let timeSignature = timeSignatureParse.run(&timeSignatureSubstring) else { throw TimeSignatureError.timeSignatureParseError(from) }
		return timeSignature
	}

	/// Based on the provided parameters, determine what kind of regular type the time signature represents.
	/// - Note: This is not meant for `.fractional` or `.additive` time signatures.
	// TODO: This is not a good way to determine the type. It should be calculated based on rules instead of a list of
	/// cases that fit in each bucket.
	static func commonType(beatsPerBar: Int, beatUnit: Int) -> Self {
		switch (beatsPerBar, beatUnit) {
		case (2, 4), (3, 4), (4, 4), (_, 4):
			return .simple(beatsPerBar, beatUnit)
		case (6, 8), (9, 8), (12, 8), (_, 8):
			return .compound(beatsPerBar, beatUnit)
		default:
			return .complex(beatsPerBar, beatUnit)
		}
	}

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		try TimeSignature.type(from: try node.value())
	}
}

// MARK: - Equality Support
extension TimeSignature: Equatable {
	public static func == (lhs: TimeSignature, rhs: TimeSignature) -> Bool {
		switch (lhs, rhs) {
		case let (.simple(lhsBeatsPerBar, lhsBeatUnit), .simple(rhsBeatsPerBar, rhsBeatUnit)) where lhsBeatsPerBar == rhsBeatsPerBar && lhsBeatUnit == rhsBeatUnit:
			return true
		case let (.compound(lhsBeatsPerBar, lhsBeatUnit), .compound(rhsBeatsPerBar, rhsBeatUnit)) where lhsBeatsPerBar == rhsBeatsPerBar && lhsBeatUnit == rhsBeatUnit:
			return true
		case let (.additive(lhsBeatsPerBar, lhsBeatUnit), .additive(rhsBeatsPerBar, rhsBeatUnit)) where lhsBeatsPerBar == rhsBeatsPerBar && lhsBeatUnit == rhsBeatUnit:
			return true
		case let (.fractional(lhsBeatsPerBar, lhsBeatUnit), .fractional(rhsBeatsPerBar, rhsBeatUnit)) where lhsBeatsPerBar == rhsBeatsPerBar && lhsBeatUnit == rhsBeatUnit:
			return true
		case let (.complex(lhsBeatsPerBar, lhsBeatUnit), .complex(rhsBeatsPerBar, rhsBeatUnit)) where lhsBeatsPerBar == rhsBeatsPerBar && lhsBeatUnit == rhsBeatUnit:
			return true
		default:
			return false
		}
	}
}

// MARK: - Time Signature String Parsing

// Used to find and consume `5` in a time signature like `5/4`.
nonisolated(unsafe) let int = Parser<Int> { str in
	let prefix = str.prefix(while: { $0.isNumber })
	let match = Int(prefix)
	str.removeFirst(prefix.count)
	return match
}

// Used to find and consume `2.5` in a time signature like `2.5/4`.
nonisolated(unsafe) let float = Parser<Float> { str in
	let prefix = str.prefix(while: { $0.isNumber || $0 == "." })
	let match = Float(prefix)
	str.removeFirst(prefix.count)
	return match
}

nonisolated(unsafe) let timeSignatureParse = Parser<TimeSignature> { str in
	if str.contains("+") {			// Check for additive signature (`3+2/8+3`)
		let beatGroupingStrings = str.split(separator: "+")

		var beatGroupings = [Int]()
		var beatUnits: Int = 0

		for group in beatGroupingStrings {
			if group.contains("/") {
				let components = group.split(separator: "/")
				guard components.count == 2 else { return nil }
				guard let beatGroupingInt = Int(components[0]),
					  let beatUnitsInt = Int(components[1])
				else { return nil }

				beatGroupings.append(beatGroupingInt)
				beatUnits = beatUnitsInt
			} else {
				guard let beatGroupingInt = Int(group) else { return nil }
				beatGroupings.append(beatGroupingInt)
			}
		}

		return beatUnits == 0 ? nil : TimeSignature.additive(beatGroupings, beatUnits)
	} else if str.contains(".") {	// Check for fractional signature (`2.5/4`)
		guard let beatsPerBar = float.run(&str),
			  literal("/").run(&str) != nil,
			  let beatUnit = int.run(&str)
		else { return nil }

		return TimeSignature.fractional(beatsPerBar, beatUnit)
	} else {						// Parse one of the normal signatures
		guard let beatsPerBar = int.run(&str),
			  literal("/").run(&str) != nil,
			  let beatUnit = int.run(&str)
		else { return nil }

		return TimeSignature.commonType(beatsPerBar: beatsPerBar, beatUnit: beatUnit)
	}
}

// MARK: - Error

enum TimeSignatureError: Error {
	case timeSignatureParseError(String)
	case unsupportedTimeSignature(String)
	case beatsPerBarNotInteger(String)
	case beatUnitNotInteger(String)
}

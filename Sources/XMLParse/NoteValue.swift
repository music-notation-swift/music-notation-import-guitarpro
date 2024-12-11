//
//	NoteValue.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

public enum NoteValue: XMLObjectDeserialization {
	static let nodeKey = "NoteValue"

	case whole
	case half
	case quarter
	case eighth
	case sixteenth
	case thirtysecond
	case sixtyforth

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		let value: String = try node.value()

		switch value {
		case "Whole":	return .whole
		case "Half":	return .half
		case "Quarter":	return .quarter
		case "Eighth":	return .eighth
		case "16th":	return .sixteenth
		case "32nd":	return .thirtysecond
		case "64th":	return .sixtyforth
		default:
			throw NoteValueError.unsupportedNoteValue(value)
		}
	}
}

public enum NoteValueError: Error {
	case unsupportedNoteValue(String)
}

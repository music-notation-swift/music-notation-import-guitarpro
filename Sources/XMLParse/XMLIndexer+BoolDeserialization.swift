//
//	XMLObjectDeserialization+Bool.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-10-18.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

extension XMLIndexer {
	/**
	Attempts to deserialize the current XMLElement element to `T`

	- throws: an XMLDeserializationError.nodeIsInvalid if the current indexed level isn't an Element
	- returns: the deserialized `T` value
	*/
	func value<T: XMLElementDeserializable>(found: T, notFound: T) throws -> T {
		switch self {
		case .element(let element):
			do {
				let deserialized = try T.deserialize(element)
				try deserialized.validate()
				return deserialized
			} catch XMLDeserializationError.nodeHasNoValue {
				return found
			}
		case .stream(_ /*let opStream*/):
			throw XMLDeserializationError.nodeIsInvalid(node: "Streaming Not Supported")
//			return try opStream.findElements().value()
		case .xmlError(let indexingError):
			if case let .key(error) = indexingError, !error.isEmpty {
				return notFound
			} else {
				throw XMLDeserializationError.nodeIsInvalid(node: indexingError.description)
			}
		default:
			throw XMLDeserializationError.nodeIsInvalid(node: "Unexpected error deserializing XMLElement -> T")
		}
	}
}

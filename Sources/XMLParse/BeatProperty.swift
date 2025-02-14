//
//	Beat.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-02-09.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
import SWXMLHash

public enum Direction: XMLObjectDeserialization {
	case down
	case up

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		let value: String = try node.value()
		switch value {
		case "Down":	return .down
		case "Up":		return .up
		default:		throw BeatDirectionPropertyParseError.unsupportedPropertyAttribute(value)
		}
	}
}

public enum BeatDirectionPropertyParseError: Error { case unsupportedPropertyAttribute(String) }

public enum BeatProperty: XMLObjectDeserialization {
	static let nodeKey = "Property"
	case primaryPickupVolume(Float)
	case primaryPickupTone(Float)
	case brush(Direction)

	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		let propertyAttribute: String = try node.value(ofAttribute: "name")

		switch propertyAttribute {
		case "PrimaryPickupVolume":	return .primaryPickupVolume(try node["Float"].value())
		case "PrimaryPickupTone":	return .primaryPickupTone(try node["Float"].value())
		case "Brush":				return .brush(try node["Direction"].value())
		case "XProperties":			return .brush(try node["Direction"].value())

		default:
			throw BeatPropertyParseError.unsupportedPropertyAttribute(propertyAttribute)
		}
	}
}

public enum BeatPropertyParseError: Error { case unsupportedPropertyAttribute(String) }

public enum ExtraProperty: XMLObjectDeserialization {
	case x1124139010(Int)
	case x1124139264(Int)
	case x1124139265(Int)
	case x1124139266(Int)
	case x1124139267(Int)
	case x1124139268(Int)
	case x1124139269(Int)
	case x1124139270(Int)
	case x1124139271(Int)
	case x1124139272(Int)
	case x1124139273(Int)
	case x1124139274(Int)
	case x1124139275(Int)
	case x1124139276(Int)
	case x1124139277(Int)
	case x1124139278(Int)
	case x1124139279(Int)
	case x1124139280(Int)
	case x1124139281(Int)
	case x1124139282(Int)
	case x1124139283(Int)
	case x1124139284(Int)
	case x1124139285(Int)
	case x1124139286(Int)
	case x1124139287(Int)
	case x1124139288(Int)
	case x1124139289(Int)
	case x1124139290(Int)
	case x1124139291(Int)
	case x1124139292(Int)
	case x1124139293(Int)
	case x1124139294(Int)
	case x1124139295(Int)
	case x1124139520(Double)
	case x1124139521(Float)
	case x1124204546(Int)
	case x1124204552(Int)
	case x687931393(Int)
	case x687931394(Float)
	case x687935489(Int)
	case x687935490(Float)

	// swiftlint:disable cyclomatic_complexity
	public static func deserialize(_ node: XMLIndexer) throws -> Self {
		let propertyAttribute: String = try node.value(ofAttribute: "id")

		switch propertyAttribute {
		case "1124139010":	return .x1124139010(try node["Int"].value())
		case "1124139264":	return .x1124139264(try node["Int"].value())
		case "1124139265":	return .x1124139265(try node["Int"].value())
		case "1124139266":	return .x1124139266(try node["Int"].value())
		case "1124139267":	return .x1124139267(try node["Int"].value())
		case "1124139268":	return .x1124139268(try node["Int"].value())
		case "1124139269":	return .x1124139269(try node["Int"].value())
		case "1124139270":	return .x1124139270(try node["Int"].value())
		case "1124139271":	return .x1124139271(try node["Int"].value())
		case "1124139272":	return .x1124139272(try node["Int"].value())
		case "1124139273":	return .x1124139273(try node["Int"].value())
		case "1124139274":	return .x1124139274(try node["Int"].value())
		case "1124139275":	return .x1124139275(try node["Int"].value())
		case "1124139276":	return .x1124139276(try node["Int"].value())
		case "1124139277":	return .x1124139277(try node["Int"].value())
		case "1124139278":	return .x1124139278(try node["Int"].value())
		case "1124139279":	return .x1124139279(try node["Int"].value())
		case "1124139280":	return .x1124139281(try node["Int"].value())
		case "1124139281":	return .x1124139281(try node["Int"].value())
		case "1124139282":	return .x1124139282(try node["Int"].value())
		case "1124139283":	return .x1124139283(try node["Int"].value())
		case "1124139284":	return .x1124139284(try node["Int"].value())
		case "1124139285":	return .x1124139285(try node["Int"].value())
		case "1124139286":	return .x1124139286(try node["Int"].value())
		case "1124139287":	return .x1124139287(try node["Int"].value())
		case "1124139288":	return .x1124139288(try node["Int"].value())
		case "1124139289":	return .x1124139289(try node["Int"].value())
		case "1124139290":	return .x1124139290(try node["Int"].value())
		case "1124139291":	return .x1124139291(try node["Int"].value())
		case "1124139292":	return .x1124139292(try node["Int"].value())
		case "1124139293":	return .x1124139293(try node["Int"].value())
		case "1124139294":	return .x1124139294(try node["Int"].value())
		case "1124139295":	return .x1124139295(try node["Int"].value())
		case "1124139520":	return .x1124139520(try node["Int"].value())
		case "1124139521":	return .x1124139521(try node["Double"].value())
		case "1124204546":	return .x1124204546(try node["Int"].value())
		case "1124204552":	return .x1124204552(try node["Int"].value())
		case "687931393":	return .x687931393(try node["Int"].value())
		case "687931394":	return .x1124139295(try node["Float"].value())
		case "687935489":	return .x687935489(try node["Int"].value())
		case "687935490":	return .x687935490(try node["Float"].value())

		default:
			throw ExtraPropertyParseError.unsupportedPropertyAttribute(propertyAttribute)
		}
	}
}

public enum ExtraPropertyParseError: Error { case unsupportedPropertyAttribute(String) }

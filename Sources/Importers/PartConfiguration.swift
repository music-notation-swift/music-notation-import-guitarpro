//
//	PartConfiguration.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-08-06.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

import Foundation

// The first two words seem to be a 32 bit version #, and then 32 bit of zero
// 00000006 00000000
// Then the PartConfiguration stuff we know, which is how do we view the score, standard, tab, etc
// 05020104 0808
// I've tried changing more of the guitar pro panel where this is set, but things only change in
// either the score.gpif of one of the `gpsv` files. There appears to be one `gpsv` file per track.
// The rest of the file is currently undeciphered.
// 0000 00000102 00000000 01010000 00000104 00000000 01080000 00000108 00000005

public struct PartConfiguration: OptionSet, Sendable {
	public let rawValue: UInt8

	static let standard		= PartConfiguration(rawValue: 1 << 0)
	static let tablature	= PartConfiguration(rawValue: 1 << 1)
	static let slash		= PartConfiguration(rawValue: 1 << 2)
	static let numbered 	= PartConfiguration(rawValue: 1 << 3)

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

// MARK: - BinaryData Importer

extension PartConfiguration {
	static func partConfigurationArrayFrom(data: Data) throws -> [PartConfiguration] {
		let dataSize = data.count
		let minimumPartConfig = MemoryLayout<UInt32>.size /* Version */ +
								MemoryLayout<UInt32>.size /* Unknown1 */ +
								MemoryLayout<UInt8>.size  /* Notation settings count */

		guard dataSize > minimumPartConfig else { throw PartConfigurationError.DataTooSmallToContainTracks }

		let binaryData = BinaryDataReader(BinaryData(data: data, bigEndian: true), readIndex: 0)
        let version: UInt32 = try binaryData.read()
        let unknown: UInt32 = try binaryData.read()

        guard version == 6 else { throw PartConfigurationError.UnhandledVersion }
        guard unknown == 0 else { throw PartConfigurationError.UnhandledUnknownBytes }

        let trackCount: UInt8 = try binaryData.read()

		var partConfigurations: [PartConfiguration] = []
		for _ in 0 ..< trackCount {
			partConfigurations.append(PartConfiguration(rawValue: try binaryData.read()))
		}

		return partConfigurations
	}
}

enum PartConfigurationError: Error {
	case DataTooSmallToContainTracks
    case UnhandledVersion
    case UnhandledUnknownBytes
}

//
//	PartConfiguration.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-08-06.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

import Foundation

public struct PartConfiguration {
    let options: UInt32
}

// MARK: - BinaryData Importer

extension PartConfiguration {
    static func partConfigurationArrayFrom(data: Data) throws -> [PartConfiguration] {
        let dataSize = data.count
        let offsetToTrackCount = 8

        let binaryData = BinaryDataReader(BinaryData(data: data), readIndex: offsetToTrackCount)
        guard dataSize > offsetToTrackCount else { throw PartConfigurationError.DataTooSmallToContainTracks }

        let trackCount: UInt16 = try binaryData.read()

        var partConfigurations: [PartConfiguration] = []
        for _ in 0 ..< trackCount {
            partConfigurations.append(PartConfiguration(options: try binaryData.read()))
        }

		return partConfigurations
    }
}

enum PartConfigurationError: Error {
    case DataTooSmallToContainTracks
}

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

        let binaryData = BinaryData(data: data)
        guard dataSize > offsetToTrackCount else { throw PartConfigurationError.DataTooSmallToContainTracks }

        let trackCount: UInt16 = try binaryData.get(offsetToTrackCount)

        var partConfigurations: [PartConfiguration] = []
        var offset: Int = offsetToTrackCount + MemoryLayout<UInt16>.size
        for _ in 0 ..< trackCount {
            partConfigurations.append(PartConfiguration(options: try binaryData.get(offset)))
            offset += MemoryLayout<UInt32>.size
        }

         return partConfigurations
    }
}

enum PartConfigurationError: Error {
    case DataTooSmallToContainTracks
}

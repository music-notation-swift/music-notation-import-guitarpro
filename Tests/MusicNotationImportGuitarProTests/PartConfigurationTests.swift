//
//	PartConfigurationTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2021-04-01.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import Foundation
import Testing

@Suite final class PartConfigurationTests {
    let data = Data(
        [UInt8](arrayLiteral:
            0x00, 0x00, 0x00, 0x06,
            0x00, 0x00, 0x00, 0x00,
            0x05, 0x02, 0x01, 0x04,
            0x08, 0x08, 0x00, 0x00,
            0x00, 0x00, 0x01, 0x02,
            0x00, 0x00, 0x00, 0x00,
            0x01, 0x01, 0x00, 0x00,
            0x00, 0x00, 0x01, 0x04,
            0x00, 0x00, 0x00, 0x00,
            0x01, 0x08, 0x00, 0x00,
            0x00, 0x00, 0x01, 0x08,
            0x00, 0x00, 0x00, 0x05
        )
    )

    @Test func parseBinaryFileAndGetSize() async throws {
        let partConfigs = try PartConfiguration.partConfigurationArrayFrom(data: data)
        #expect(partConfigs.count == 5)
    }

    @Test func parseBinaryFileForParts() async throws {
        let partConfigs = try PartConfiguration.partConfigurationArrayFrom(data: data)
        #expect(partConfigs[0].contains(PartConfiguration.tablature) == true)
        #expect(partConfigs[1].contains(PartConfiguration.standard) == true)
        #expect(partConfigs[2].contains(PartConfiguration.slash) == true)
        #expect(partConfigs[3].contains(PartConfiguration.numbered) == true)
        #expect(partConfigs[4].contains(PartConfiguration.numbered) == true)
    }
}

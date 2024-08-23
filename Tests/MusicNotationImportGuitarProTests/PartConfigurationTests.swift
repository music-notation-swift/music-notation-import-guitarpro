//
//	PartConfigurationTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2021-04-01.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation
@testable import MusicNotationImportGuitarPro
import Testing

@Suite final class PartConfigurationTests {
    let data = Data([UInt8](arrayLiteral:
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
    ))

    @Test func parseBinaryFileAndGetSize() async throws {
        let partConfigs = try PartConfiguration.partConfigurationArrayFrom(data: data)
        #expect(partConfigs.count == 5)
    }
}
//
//	VersionTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2021-02-10.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import Testing

@Suite final class VersionTests {
	@Test func invalidVersionString1() async throws {
		#expect(throws: VersionError.versionStringMissingComponents) {
			_ = try Version.withString("asdfasdfasdf")
		}
	}

	@Test func invalidVersionString2() async throws {
		#expect(throws: VersionError.versionStringMisformed) {
			_ = try Version.withString("asdfa.sd.fasdf")
		}
	}

	@Test func invalidVersionString3() async throws {
		#expect(throws: VersionError.versionStringMisformed) {
			_ = try Version.withString("1.sd.fasdf")
		}
	}

	@Test func invalidVersionString4() async throws {
		#expect(throws: VersionError.versionStringMisformed) {
			_ = try Version.withString("1.1.fasdf")
		}
	}

	@Test func invalidVersionString5() async throws {
		#expect(throws: VersionError.versionStringMisformed) {
			_ = try Version.withString("1.asd.1")
		}
	}

	@Test func invalidVersionString6() async throws {
		#expect(throws: VersionError.versionStringMissingComponents) {
			_ = try Version.withString("1.asd")
		}
	}
}

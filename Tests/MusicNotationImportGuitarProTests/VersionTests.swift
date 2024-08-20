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
	@Test func invalidVersionStringText1() async throws {
		#expect(throws: VersionError.versionStringMissingComponents) {
			_ = try Version.withString("asdfasdfasdf")
		}
	}

	@Test func invalidVersionStringText2() async throws {
		#expect(throws: VersionError.versionStringMisformed) {
			_ = try Version.withString("asdfa.sd.fasdf")
		}
	}

	@Test func invalidVersionStringText3() async throws {
		#expect(throws: VersionError.versionStringMisformed) {
			_ = try Version.withString("1.sd.fasdf")
		}
	}

	@Test func invalidVersionStringText4() async throws {
		#expect(throws: VersionError.versionStringMisformed) {
			_ = try Version.withString("1.1.fasdf")
		}
	}

	@Test func invalidVersionStringText5() async throws {
		#expect(throws: VersionError.versionStringMisformed) {
			_ = try Version.withString("1.asd.1")
		}
	}

	@Test func invalidVersionStringText6() async throws {
		#expect(throws: VersionError.versionStringMissingComponents) {
			_ = try Version.withString("1.asd")
		}
	}

	@Test func validVersionString() async throws {
		let version = try Version.withString("1.2.3-rc4")
		#expect(version.major == 1)
		#expect(version.minor == 2)
		#expect(version.patch == 3)
		#expect(version.prerelease == "rc4")
	}
}

//
//  BinaryDataReaderTests.swift
//  BinarySwift
//
//  Created by Łukasz Kwoska on 12/04/16.
//  Copyright © 2016 Spinal Development.com. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import Testing

@Suite final class BinaryDataReaderTests {
	@Test func readUInt8() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0xff, 0x05]))
		let uint8_255 = try? reader.read() as UInt8
		let uint8_5 = try? reader.read() as UInt8
		let uint8 = try? reader.read() as UInt8?
		#expect(uint8_255 == 255)
		#expect(uint8_5 == 5)
		#expect(uint8 == nil)
	}

	@Test func readInt8() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0xff, 0x05]))
		#expect((try? reader.read() as Int8) == -1)
		#expect((try? reader.read() as Int8) == 5)
		#expect((try? reader.read() as Int8?) == nil)
	}

	@Test func readUInt16() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x00, 0x00]))
		#expect((try? reader.read() as UInt16) == 0xff00)
		#expect((try? reader.read() as UInt16) == 0xcc00)
		#expect((try? reader.read() as UInt16?) == nil)
	}

	@Test func readInt16() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x00, 0x00]))
		let minus256 = try? reader.read() as Int16
		let minus13 = try? reader.read() as Int16
		#expect(minus256 == -256)
		#expect(minus13 == -13312)
		#expect((try? reader.read() as Int16?) == nil)
	}

	@Test func readUInt32() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x11, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00]))
		#expect((try? reader.read() as UInt32) == 0xff00cc11)
		#expect((try? reader.read() as UInt32) == 5)
		#expect((try? reader.read() as UInt32?) == nil)
	}

	@Test func readInt32() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00]))
		#expect((try? reader.read() as Int32) == -16777216)
		#expect((try? reader.read() as Int32) == 255)
		#expect((try? reader.read() as Int32?) == nil)
	}

	@Test func readUInt64() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x11, 0x00, 0x00, 0x00, 0xab, 0x00, 0x00, 0x00, 0x00, 0x00]))
		#expect((try? reader.read() as UInt64) == 0xff00cc11000000ab)
		#expect((try? reader.read() as UInt64?) == nil)
	}

	@Test func readInt64() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0xff, 0x00, 0xcc, 0x11, 0x00, 0x00, 0x00, 0xab, 0x00, 0x00, 0x00, 0x00, 0x00]))
		#expect((try? reader.read() as Int64) == -71833220651417429)
		#expect((try? reader.read() as Int64?) == nil)
	}

	@Test func readFloat32() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0x40, 0x20, 0x00, 0x00, 0x40, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00]))
		#expect((try? reader.read() as Float32) == 2.5)
		#expect((try? reader.read() as Float32) == 2.75)
		#expect((try? reader.read() as Float32?) == nil)
	}

	@Test func readFloat64() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0x40, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]))
		#expect((try? reader.read() as Float64) == 8.0)
		#expect((try? reader.read() as Float64) == 16.0)
		#expect((try? reader.read() as Float64?) == nil)
	}

	@Test func readNullTerminatedString() async throws {
		let string = "Test string"
		let bytes = Array(string.utf8CString).map {UInt8($0)}
		let reader = BinaryDataReader(BinaryData(data: bytes + bytes + [0x0, 0x12]))

		#expect((try? reader.readNullTerminatedUTF8()) == string)
		#expect((try? reader.readNullTerminatedUTF8()) == string)
		#expect((try? reader.readNullTerminatedUTF8()) == "")
		#expect((try? reader.readNullTerminatedUTF8()) == nil)
	}

	@Test func readString() async throws {
		let string = "Test string"
		let bytes = Array(string.utf8)
		let reader = BinaryDataReader(BinaryData(data: bytes + bytes + [0x0, 0x12]))

		#expect((try? reader.readUTF8(11)) == string)
		#expect((try? reader.readUTF8(11)) == string)
		#expect((try? reader.readUTF8(0)) == "")
		#expect((try? reader.readUTF8(11)) == nil)
	}

	@Test func readSubData() async throws {
		let reader = BinaryDataReader(BinaryData(data:[0x40, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]))
		let subdata1 = try? reader.read(8) as BinaryData
		let subdata2 = try? reader.read(8) as BinaryData
		#expect(subdata1?.data ?? [] == [0x40, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
		#expect(subdata2?.data ?? [] == [0x40, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
	}
}

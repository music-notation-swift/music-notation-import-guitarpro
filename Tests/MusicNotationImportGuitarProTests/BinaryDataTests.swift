//
//  BinaryDataTests.swift
//  BinarySwift
//
//  Created by Łukasz Kwoska on 11/04/16.
//  Copyright © 2016 Spinal Development.com. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import Foundation
import Testing

@Suite final class BinaryDataTests {
	let intData = BinaryData(data: [0xff, 0x11, 0x00, 0xef, 0x76, 0x12, 0x98, 0xff])
	let floatData = BinaryData(data:[0x40, 0x20, 0x00, 0x00])
	let doubleData = BinaryData(data:[0x40, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])

	// MARK: - Initialization

	@Test func arrayLiteralInit() async throws {
		let data: BinaryData = [0xf, 0x00, 0x1, 0xa]
		#expect(data.data == [0xf, 0x00, 0x1, 0xa])
		#expect(data.bigEndian == true)
	}

	@Test func arrayInit() async throws {
		let data = BinaryData(data: [0xf, 0x00, 0x1, 0xa])
		#expect(data.data == [0xf, 0x00, 0x1, 0xa])
		#expect(data.bigEndian == true)

		let dataExplicitBigEndianTrue = BinaryData(data: [0xf, 0x00, 0x1, 0xa], bigEndian: true)
		#expect(dataExplicitBigEndianTrue.data == [0xf, 0x00, 0x1, 0xa])
		#expect(dataExplicitBigEndianTrue.bigEndian == true)

		let dataExplicitBigEndianFalse = BinaryData(data: [0xf, 0x00, 0x1, 0xa], bigEndian: false)
		#expect(dataExplicitBigEndianFalse.data == [0xf, 0x00, 0x1, 0xa])
		#expect(dataExplicitBigEndianFalse.bigEndian == false)
	}

	@Test func nsDataInit() async throws {
		guard let nsData = Data(base64Encoded: "MTIzNA==", options: Data.Base64DecodingOptions())
		else { Issue.record("Failed to decode test Base64 string"); return }

		let data = BinaryData(data: nsData)
		#expect(data.data == [49, 50, 51, 52])
		#expect(data.bigEndian == true)

		let dataExplicitBigEndianTrue = BinaryData(data: nsData, bigEndian: true)
		#expect(dataExplicitBigEndianTrue.data == [49, 50, 51, 52])
		#expect(dataExplicitBigEndianTrue.bigEndian == true)

		let dataExplicitBigEndianFalse = BinaryData(data: nsData, bigEndian: false)
		#expect(dataExplicitBigEndianFalse.data == [49, 50, 51, 52])
		#expect(dataExplicitBigEndianFalse.bigEndian == false)
	}

	// MARK: - Reading One - byte values

	@Test func getUInt8() async throws {
		let value: UInt8? = try? intData.get(0)
		#expect(value == 255)
	}

	@Test func getInt8() async throws {
		let value: Int8? = try? intData.get(0)
		#expect(value == -1)
	}

	// MARK: - Reading Two - byte values

	@Test func getUInt16() async throws {
		let value: UInt16? = try? intData.get(0)
		#expect(value == 65297)
	}

	@Test func getInt16() async throws {
		let value: Int16? = try? intData.get(0)
		#expect(value == -239)
	}

	@Test func getUInt16LittleEndian() async throws {
		let value: UInt16? = try? intData.get(0, bigEndian:false)
		#expect(value == 4607)
	}

	@Test func getInt16LittleEndian() async throws {
		let value: Int16? = try? intData.get(0, bigEndian:false)
		#expect(value == 4607)
	}

	// MARK: - Reading Four - byte values

	@Test func getUInt32() async throws {
		let value: UInt32? = try? intData.get(0)
		#expect(value == 4279304431)
	}

	func getInt32() async throws {
		let value: Int32? = try? intData.get(0)
		#expect(value == -15662865)
	}

	@Test func getUInt32LittleEndian() async throws {
		let value: UInt32? = try? intData.get(0, bigEndian:false)
		#expect(value == 4009759231)
	}

	@Test func getInt32LittleEndian() async throws {
		let value: Int32? = try? intData.get(0, bigEndian:false)
		#expect(value == -285208065)
	}

	// MARK: - Reading Eight - byte values

	@Test func getUInt64() async throws {
		let value: UInt64? = try? intData.get(0)
		#expect(value == 18379472582753818879)
	}

	@Test func getInt64() async throws {
		let value: Int64? = try? intData.get(0)
		#expect(value == -67271490955732737)
	}

	@Test func getUInt64LittleEndian() async throws {
		let value: UInt64? = try? intData.get(0, bigEndian:false)
		#expect(value == 18417490978156843519)
	}

	@Test func getInt64LittleEndian() async throws {
		let value: Int64? = try? intData.get(0, bigEndian:false)
		#expect(value == -29253095552708097)
	}

	// MARK: - Reading Floats

	@Test func getFloat32() async throws {
		let value: Float32? = try? floatData.get(0)
		#expect(value == 2.5)
	}

	@Test func getFloat64() async throws {
		let value: Float64? = try? doubleData.get(0)
		#expect(value == 8.0)
	}

	// MARK: - Test reading String
	@Test func getNullTerminatedString() async throws {
		let testString = "TestData"
		let bytes = Array(testString.utf8CString).map {UInt8($0)}
		let data = BinaryData(data: bytes + bytes)
		print (bytes)
		#expect((try? data.getNullTerminatedUTF8(0)) == testString)
	}

	@Test func getString() async throws {
		let testString = "Test"
		let data = BinaryData(data: Array(testString.utf8CString).map {UInt8($0)})
		#expect((try? data.getUTF8(0, length: 4)) == testString)
	}

	// MARK: - Test reading subdata

	@Test func getSubData() async throws {
		#expect(((try? intData.subData(1, 2).data) ?? []) == [0x11, 0x00])
	}

	@Test func tail() async throws {
		#expect(((try? intData.tail(1).data) ?? []) == [0x11, 0x00, 0xef, 0x76, 0x12, 0x98, 0xff])
	}
}

//
//	TimeSignatureParserTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2021-02-24.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import Testing

/// There are issues with the domain knowledge acquired and that needed to properly implement
/// a good deal of Time Signatures parsing.
///
/// I have not been able to find enough data to correctly parse and algorithmically determine
/// what is a simple, compound, complex time signature as well as the state of `oddness` of a time signature.
///
/// For now this will have to do and I will ammend the code and tests when I have better domain expertise.
@Suite final class TimeSignatureParserTests {
	@Test func simple() async throws {
		let signature1 = try TimeSignature.type(from: "4/4")
		#expect(signature1 == .simple(4, 4))
		let signature2 = try TimeSignature.type(from: "2/4")
		#expect(signature2 == .simple(2, 4))
		let signature3 = try TimeSignature.type(from: "3/4")
		#expect(signature3 == .simple(3, 4))
	}

	@Test func compound() async throws {
		let signature1 = try TimeSignature.type(from: "3/8")
		#expect(signature1 == .compound(3, 8))
		let signature2 = try TimeSignature.type(from: "6/8")
		#expect(signature2 == .compound(6, 8))
		let signature3 = try TimeSignature.type(from: "9/8")
		#expect(signature3 == .compound(9, 8))
		let signature4 = try TimeSignature.type(from: "12/8")
		#expect(signature4 == .compound(12, 8))
	}

	@Test func odd() async throws {
		let signature1 = try TimeSignature.type(from: "5/4")
		#expect(signature1.oddMeter())
		let signature2 = try TimeSignature.type(from: "7/8")
		#expect(signature2.oddMeter())
		let signature3 = try TimeSignature.type(from: "11/16")
		#expect(signature3.oddMeter())
		let signature4 = try TimeSignature.type(from: "7/16")
		#expect(signature4.oddMeter())
	}

	@Test func complex() async throws {
		let signature1 = try TimeSignature.type(from: "6/3")
		#expect(signature1 == .complex(6, 3))
		let signature2 = try TimeSignature.type(from: "5/24")
		#expect(signature2 == .complex(5, 24))
		let signature3 = try TimeSignature.type(from: "3/10")
		#expect(signature3 == .complex(3, 10))
	}

	@Test func fractional() async throws {
		let fractionalSignature1 = try TimeSignature.type(from: "2.5/4")
		#expect(fractionalSignature1 == .fractional(2.5, 4))
		let fractionalSignature2 = try TimeSignature.type(from: "5.1/24")
		#expect(fractionalSignature2 == .fractional(5.1, 24))
		let fractionalSignature3 = try TimeSignature.type(from: "3.666/10")
		#expect(fractionalSignature3 == .fractional(3.666, 10))
	}

	@Test func additive() async throws {
		let additiveSignature = try TimeSignature.type(from: "3+2/8+3")
		#expect(additiveSignature == .additive([3, 2, 3], 8))
//		_ = try TimeSignature.type(from: "")
	}
}

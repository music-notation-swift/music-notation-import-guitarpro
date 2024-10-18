//
//	GuitarProImporterTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-15.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import Foundation
import SWXMLHash
import System
import Testing
import ZIPFoundation

@Suite final class GuitarProImporterTests {
	@Test(arguments: ["Test1.gp", "Test1.gpif"])
	func initTest(filename: String) async throws {
		let filenamePath = FilePath(filename)
		guard let filePath = Bundle.module.path(
			forResource: filenamePath.stem,
			ofType: filenamePath.extension,
			inDirectory: "TestFiles"
		) else {
			Issue.record("Bundle path not found (\(filename))")
			return
		}

		let filePathURL = URL(fileURLWithPath: filePath)
		let importer = GuitarPro8Importer(
			file: filePathURL,
			verbose: false,
			lazy: false
		)

		#expect(importer.file == filePathURL)
	}

	@Test func unzipToString() async throws {
		let filePathURL = try filePathURL(from: "testzip.zip")
		let importer = GuitarPro8Importer(
			file: filePathURL,
			verbose: false,
			lazy: false
		)

		guard let archive = try? Archive(url: filePathURL, accessMode: .read, pathEncoding: nil)
		else { throw GuitarProImportError(file: filePathURL, "Could not open gp archive") }
		guard let zipEntry = archive["testzip.txt"]
		else { throw GuitarProImportError(file: filePathURL, "Could not open XML file inside mscz archive") }

		#expect(try importer.unzipToString(archive, entry: zipEntry) == "testzip")
	}

	@Test(arguments: ["Test1.gp"])
	func createStringFromFileTest(filename: String) async throws {
		let importer = try importer(from: filename)
		#expect(try importer.createFromFile().0 != "")
	}

	@Test(arguments: ["Test1.bad"])
	func createStringFromBadFileTest(filename: String) async throws {
		let importer = try importer(from: filename)
		#expect(throws: GuitarProImportError.self) {
			_ = try importer.createFromFile()
		}
	}

	@Test func parseXML() async throws {
		let importer = try importer(from: "Test1.gpif")
		let (xmlString, _) = try importer.createFromFile()
		let interchangeFormat = try importer.parseXML(xmlString)
		#expect(interchangeFormat.bars.count > 0)
	}

	func filePathURL(from filename: String) throws -> URL {
		let filenamePath = FilePath(filename)
		guard let filePath = Bundle.module.path(
			forResource: filenamePath.stem,
			ofType: filenamePath.extension,
			inDirectory: "TestFiles"
		) else {
			Issue.record("Bundle path not found (\(filename))")
			throw GuitarProImporterTestError.generalFailure
		}

		return URL(fileURLWithPath: filePath)
	}

	func importer(from filename: String) throws -> GuitarPro8Importer {
		let fileURL = try filePathURL(from: filename)
		return GuitarPro8Importer(
			file: fileURL,
			verbose: false,
			lazy: false
		)
	}
}

enum GuitarProImporterTestError: Error {
	case generalFailure
}

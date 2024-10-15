//
//	GuitarPro8Importer.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-08-06.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

import Foundation
import MusicNotation
import SWXMLHash
import ZIPFoundation

public struct GuitarPro8Importer {
	public let file: URL
	public let verbose: Bool
	public let lazy: Bool

	public init(file: URL, verbose: Bool, lazy: Bool) {
		self.file = file
		self.verbose = verbose
		self.lazy = lazy
	}

	public func consume() throws -> MusicNotation.Score {
		if verbose { print("--- Starting parsing of: \(file) ---") }
		defer { if verbose { print("--- Ending parsing of: \(file) ---") } }

		let both = try createFromFile()
		let notation = try createNotation(
			with: try parseXML(both.0),
			partConfigurations: try PartConfiguration.partConfigurationArrayFrom(data: both.1)
		)

		return notation
	}

	func createFromFile() throws -> (String, Data) {
		if file.pathExtension == "gpif" {
			guard let string = try? String(contentsOf: file) else { throw GuitarProImportError(file: file, "Could not open gpif file") }
			return (string, Data())
		} else if file.pathExtension == "gp" {
			guard let archive = try? Archive(url: file, accessMode: .read, pathEncoding: nil) else { throw GuitarProImportError(file: file, "Could not open gp archive") }
			guard let scoreEntry = archive["Content/score.gpif"] else { throw GuitarProImportError(file: file, "Could not open score.gpif inside gp archive") }
			guard let partConfigurationEntry = archive["Content/PartConfiguration"] else { throw GuitarProImportError(file: file, "Could not open PartConfiguration inside gp archive") }

			return (try unzipToString(archive, entry: scoreEntry), try unzipToData(archive, entry: partConfigurationEntry))
		}

		throw GuitarProImportError(file: file, "Unsupported filetype")
	}

	func unzipToString(_ archive: Archive, entry: Entry) throws -> String {
		var xmlData = Data()

		_ = try archive.extract(entry, consumer: { data in
			xmlData.append(data)
		})

		guard let string = String(data: xmlData, encoding: .utf8) else { throw GuitarProImportError(file: file, "Could not convert data from archive to string") }
		return string
	}

	func unzipToData(_ archive: Archive, entry: Entry) throws -> Data {
		var entryData = Data()

		_ = try archive.extract(entry, consumer: { data in
			entryData.append(data)
		})

		return entryData
	}

	// Parse the XML of the score
	func parseXML(_ xmlString: String) throws -> MusicNotationImportGuitarPro.GuitarProInterchangeFormat {
		let xml = XMLHash.config { config in
			config.shouldProcessLazily = lazy
			config.detectParsingErrors = true
		}.parse(xmlString)

		return try xml["GPIF"].value()
	}

	public func createNotation(
		with interchangeFormat: MusicNotationImportGuitarPro.GuitarProInterchangeFormat,
		partConfigurations: [PartConfiguration]
	) throws -> MusicNotation.Score {
		let parts = interchangeFormat.tracks.map { track in
			MusicNotation.Part(with: track)
		}

		// Collect score field names

		return MusicNotation.Score(
			parts: parts,
			title: interchangeFormat.score.title,
			subtitle: interchangeFormat.score.subtitle,
			artist: interchangeFormat.score.artist,
			album: interchangeFormat.score.album,
			words: interchangeFormat.score.words,
			wordsAndMusic: interchangeFormat.score.wordsAndMusic,
			transcriber: interchangeFormat.score.tabber,
			instructions: interchangeFormat.score.instructions,
			notices: interchangeFormat.score.notices
		)
	}
}

public struct GuitarProImportError: Error, CustomStringConvertible {
	public internal(set) var file: URL
	public internal(set) var message: String

	/// Creates a new validation error with the given message.
	public init(file: URL, _ message: String) {
		self.file = file
		self.message = message
	}

	public var description: String { message }
}

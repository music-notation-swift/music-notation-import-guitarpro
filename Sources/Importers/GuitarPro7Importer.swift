//
//	GuitarPro7Importer.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-08-06.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

import Foundation
import MusicNotation
import SWXMLHash
import ZIPFoundation

public struct GuitarPro7Importer {
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

		var xmlString: String
        var partConfigurationsData: Data

		switch file.pathExtension {
		case "gpif":
			guard let string = try? String(contentsOf: file) else { throw GuitarProImportError(file: file, "Could not open gpif file") }
			xmlString = string
            partConfigurationsData = Data()

		case "gp":
            guard let archive = try? Archive(url: file, accessMode: .read, pathEncoding: nil) else { throw GuitarProImportError(file: file, "Could not open gp archive") }
			guard let scoreEntry = archive["Content/score.gpif"] else { throw GuitarProImportError(file: file, "Could not open score.gpif inside gp archive") }
            guard let partConfigurationEntry = archive["Content/PartConfiguration"] else { throw GuitarProImportError(file: file, "Could not open PartConfiguration inside gp archive") }

			xmlString = try unzipToString(archive, entry: scoreEntry)
            partConfigurationsData = try unzipToData(archive, entry: partConfigurationEntry)

		default:
			xmlString = ""
            partConfigurationsData = Data()
		}

        let notation = try createNotation(
            with: try parseXML(xmlString),
            partConfigurations: try PartConfiguration.partConfigurationArrayFrom(data: partConfigurationsData)
        )

        return notation
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
        
		return MusicNotation.Score(parts: parts)
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

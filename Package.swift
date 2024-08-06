// swift-tools-version:5.10
//
//  Package.swift
//  MusicNotationImport
//
//  Created by Steven Woolgar on 10/16/2020.
//  Copyright © 2020 Steven Woolgar. All rights reserved.
//
import PackageDescription

let package = Package(
	name: "music-notation-import-guitarpro",
	platforms: [.macOS(.v11)],
	products: [.library(name: "MusicNotationImportGuitarPro", targets: ["MusicNotationImportGuitarPro"])],

	dependencies: [
		.package(url: "https://github.com/music-notation-swift/music-notation.git", from: "0.2.5"),
		.package(url: "https://github.com/drmohundro/SWXMLHash.git", from: "7.0.2"),
	],

	targets: [
		.target(
			name: "MusicNotationImportGuitarPro",
			dependencies: [
				"SWXMLHash",
				.product(name: "MusicNotation", package: "music-notation")
			],
			path: "Sources",
			exclude: ["../images"]
		),
		.testTarget(
			name: "MusicNotationImportGuitarProTests",
			dependencies: ["MusicNotationImportGuitarPro"]
		)
	],

	swiftLanguageVersions: [ .v5 ]
)

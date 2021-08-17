// swift-tools-version:5.4
import PackageDescription

let package = Package(
	name: "music-notation-import-guitarpro",
	platforms: [.macOS(.v11)],
	products: [.library(name: "MusicNotationImportGuitarPro", targets: ["MusicNotationImportGuitarPro"])],

	dependencies: [
		.package(url: "https://github.com/music-notation-swift/music-notation.git", from: "0.2.5"),
		.package(url: "https://github.com/drmohundro/SWXMLHash.git", from: "5.0.2"),
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
	]
)

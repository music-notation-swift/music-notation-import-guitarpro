// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "music-notation-import-guitarpro",
    platforms: [.macOS(.v10_15)],
    products: [.library(name: "MusicNotationImportGuitarPro", targets: ["MusicNotationImportGuitarPro"])],
	dependencies: [.package(url: "https://github.com/drmohundro/SWXMLHash.git", from: "5.0.2")],
    targets: [
		.target(name: "MusicNotationImportGuitarPro", dependencies: ["SWXMLHash"], path: "Sources", exclude: ["images"]),
        .testTarget(name: "MusicNotationImportGuitarProTests", dependencies: ["MusicNotationImportGuitarPro"])
    ]
)
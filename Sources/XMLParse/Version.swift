//
//	Version.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-08-10.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

public struct Version {
    var major: Int
    var minor: Int
    var patch: Int
    var prerelease: String

    static func withString(_ string: String) throws -> Self {
        let prereleaseComponents = string.split(separator: "-")
        guard prereleaseComponents.count > 0 else { throw VersionError.versionStringMisformed }

        var seperatorCount = 0
        let prereleaseString: String = if prereleaseComponents.count > 1 {
            String(prereleaseComponents[1])
        } else {
            ""
        }
        if !prereleaseString.isEmpty {
            seperatorCount = 1
        }

        let componentsString = string.dropLast(prereleaseString.count + seperatorCount)
        let components = componentsString.split(separator: ".")

		guard components.count >= 3 else { throw VersionError.versionStringMissingComponents }
		guard Int(components[0]) != nil else { throw VersionError.versionStringMisformed }
		guard Int(components[1]) != nil else { throw VersionError.versionStringMisformed }
		guard Int(components[2]) != nil else { throw VersionError.versionStringMisformed }

        return Version(
            major: Int(components[0]) ?? 0,
            minor: Int(components[1]) ?? 0,
            patch: Int(components[2]) ?? 0,
            prerelease: prereleaseString
        )
    }

}

public enum VersionError: Error {
    case versionStringMissingComponents
    case versionStringMisformed
}


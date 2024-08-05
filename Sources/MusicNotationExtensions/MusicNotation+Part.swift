//
//	Staff.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-03-30.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import MusicNotation

/// An extension to create MusicNotation.Staff from a Track struct.
/// This is a function of the GP7 importer and NOT of the Staff struct.
public extension MusicNotation.Part {
	init(with track: Track) {
		self.init(name: track.name, shortName: track.shortName, staves: [])
	}
}

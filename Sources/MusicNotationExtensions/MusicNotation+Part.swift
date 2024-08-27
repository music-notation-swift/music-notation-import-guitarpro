//
//	MusicNotation+Part.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2021-03-30.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import MusicNotation

/// An extension to create MusicNotation.Staff from a Track struct.
/// This is a function of the GP7 importer and NOT of the Staff struct.
extension MusicNotation.Part {
	init(with track: Track) {
		let staves: [MusicNotation.Staff] = track.staves.map {
			MusicNotation.Staff(with: $0)
		}

		self.init(name: track.name, shortName: track.shortName, staves: staves)
	}
}

extension MusicNotation.Staff {
	init(with staff: Staff) {
		self.init(
			clef: .treble,
			instrument: .init(name: "instrument"),
			measure: [Measure(
				timeSignature: MusicNotation.TimeSignature(numerator: 4, denominator: 4, tempo: 120),
				key: MusicNotation.Key(noteLetter: .c)
			)]
		)
	}
}

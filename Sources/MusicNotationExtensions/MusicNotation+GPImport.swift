//
//	MusicNotation+GPImport.swift
//	music-notation-import-guitarpro
//
//	Created by Steven Woolgar on 2024-10-03.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

/// This is a series of helpers to make the creation of MusicNotation classes from the
/// GuitarPro classes. These MUST not be in MusicNotation because they are purely used
/// for import purposes.

import MusicNotation

// MARK: - Part Import

/// An extension to create MusicNotation.Part from a GuitarPro.Track struct.
/// This is a function of the GuitarPro importer and NOT of the MusicNotation Part struct.
extension MusicNotation.Part {
	init(with guitarProTrack: Track) {
		let staves: [MusicNotation.Staff] = guitarProTrack.staves.map {
			MusicNotation.Staff(with: $0)
		}

		self.init(/*name: guitarProTrack.name, shortName: guitarProTrack.shortName,*/ staves: staves)
	}
}

// MARK: - Part Staff

/// An extension to create MusicNotation.Staff from a GuitarPro.Track struct.
/// This is a function of the GuitarPro importer and NOT of the Staff struct.
extension MusicNotation.Staff {
	// The GuitarPro.Staff does not have a clef. That is added as part of a clef object.
	init(with guitarProStaff: Staff) {
		self.init(
			clef: .treble,
			measure: [Measure(
				timeSignature: MusicNotation.TimeSignature(numerator: 4, denominator: 4, tempo: 120),
				key: MusicNotation.Key(noteLetter: .c)
			)]
		)
	}
}

// MARK: - Part Instrument

/// An extension to create MusicNotation.Instrument from a GuitarPro.Staff.Properties array.
/// This is a function of the GuitarPro importer and NOT of the Staff struct.
extension MusicNotation.Instrument {
	// The GuitarPro.Staff does not have a clef. That is added as part of a clef object.
	init(with guitarProStaffProperties: [StaffProperty]) {
		self.init()
	}
}

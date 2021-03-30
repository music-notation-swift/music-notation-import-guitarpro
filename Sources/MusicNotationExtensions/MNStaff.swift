//
//	Staff.swift
//	music-notation
//
//	Created by Steven Woolgar on 2021-03-30.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import MusicNotation

public extension MusicNotation.Staff {
	init(with: Track) {
		self.init(clef: Clef.treble, instrument: .guitar6)
	}
}

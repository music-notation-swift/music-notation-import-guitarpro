//
//	StringParser.swift
//	music-notation-import
//
//	Created by Steven Woolgar on 2021-02-24.
//	Copyright © 2021 Steven Woolgar. All rights reserved.
//

import Foundation

// MARK: Parser composable base

public struct Parser<A> {
	let run: (inout Substring) -> A?
}

public func literal(_ literal: String) -> Parser<Void> {
	Parser<Void> { str in
		guard str.hasPrefix(literal) else { return nil }
		str.removeFirst(literal.count)
		return ()
	}
}

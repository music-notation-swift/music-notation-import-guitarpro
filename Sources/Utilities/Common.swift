//
//  Common.swift
//  music-notation-import-guitarpro
//
//  Created by Łukasz Kwoska on 09.12.2015.
//  Copyright © 2015 Macoscope Sp. z o.o. All rights reserved.
//

import Foundation

func unsafeConversion<FROM, TO>(_ from: FROM) -> TO {
	func ptr(_ fromPtr: UnsafePointer<FROM>) -> UnsafePointer<TO> {
		fromPtr.withMemoryRebound(to: TO.self, capacity: 1) {  $0 }
	}

	var fromVar = from
	return ptr(&fromVar).pointee
}

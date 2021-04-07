//
//  Flip.swift
//  
//
//  Created by Mikael Konradsson on 2021-04-07.
//

import Foundation

public func flip<A, B, C>(
	_ f: @escaping (A) -> (B) -> C
) -> (B) -> (A) -> C {
	return { b in { a in f(a)(b) } }
}

public func flip<A, B>(
	_ f: @escaping (A) -> () -> B
) -> () -> (A) -> B {
	return { { a in f(a)() } }
}

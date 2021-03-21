//
//  Fish.swift
//  
//
//  Created by Mikael Konradsson on 2021-03-21.
//

import Foundation

// MARK:- Fishy compose
precedencegroup Fish { associativity: left higherThan: Pipe }
infix operator >=>: Fish
public func >=> <A, B, C>(_ f: @escaping (A) -> B?, _ g: @escaping (B) -> C) -> (A) -> C? {
	return { a in f(a).flatMap(g) }
}

public func >=> <A, B, C>(
	_ f: @escaping (A) -> Result<B, Error>,
	_ g: @escaping (B) -> Result<C, Error>
) -> (A) -> Result<C, Error> {
	return { f($0).flatMap(g) }
}

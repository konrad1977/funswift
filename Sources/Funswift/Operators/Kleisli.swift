//
//  Fish.swift
//  
//
//  Created by Mikael Konradsson on 2021-03-21.
//

import Foundation

// MARK:- Kleisli composition
precedencegroup Kleisli { associativity: left higherThan: Pipe }
infix operator >=>: Kleisli

// MARK: - Optionals
public func >=> <A, B, C>(
	_ f: @escaping (A) -> B?,
	_ g: @escaping (B) -> C?
) -> (A) -> C? {
	return { f($0).flatMap(g) }
}

// MARK: - Result
public func >=> <A, B, C>(
	_ f: @escaping (A) -> Result<B, Error>,
	_ g: @escaping (B) -> Result<C, Error>
) -> (A) -> Result<C, Error> {
	return { f($0).flatMap(g) }
}

// MARK: - Arrays
public func >=> <A, B, C>(
    _ f: @escaping (A) -> [B],
    _ g: @escaping (B) -> [C]
) -> (A) -> [C] {
    return { f($0).flatMap(g) }
}

// MARK: - Changeable
public func >=> <A, B, C>(
	_ f: @escaping (A) -> Changeable<B>,
	_ g: @escaping (B) -> Changeable<C>
) -> (A) -> Changeable<C> {
	return { f($0).flatMap(g) }
}

// MARK: - IO
public func >=> <A, B, C>(
	_ f: @escaping (A) -> IO<B>,
	_ g: @escaping (B) -> IO<C>
) -> (A) -> IO<C> {
	return { f($0).flatMap(g) }
}

// MARK: - Deferred
public func >=> <A, B, C>(
	_ f: @escaping (A) -> Deferred<B>,
	_ g: @escaping (B) -> Deferred<C>
) -> (A) -> Deferred<C> {
	return { f($0).flatMap(g) }
}

// MARK: - Reader
public func >=> <A, B, C, Environment>(
	_ f: @escaping (A) -> Reader<Environment, B>,
	_ g: @escaping (B) -> Reader<Environment, C>
) -> (A) -> Reader<Environment, C> {
	return { f($0).flatMap(g) }
}

// MARK: - Writer
public func >=> <A, B, C, M: Monoid>(
	_ f: @escaping (A) -> Writer<B, M>,
	_ g: @escaping (B) -> Writer<C, M>
) -> (A) -> Writer<C, M> {
	return { f($0).flatMap(g) }
}

public func >=> <A, B, C, M: Monoid>(
    _ f: @escaping (A) -> Writer<B, M>,
    _ g: @escaping (B) -> C
) -> (A) -> Writer<C, M> {
    return { f($0).map(g) }
}

// MARK: - State
public func >=> <A, B, C, S>(
	_ f: @escaping (A) -> State<S, B>,
	_ g: @escaping (B) -> State<S, C>
) -> (A) -> State<S, C> {
	return { f($0).flatMap(g) }
}

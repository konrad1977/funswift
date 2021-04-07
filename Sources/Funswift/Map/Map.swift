//
//  Map.swift
//  
//
//  Created by Mikael Konradsson on 2021-04-07.
//

import Foundation

public func map<A, B>(
	_ f: @escaping (A) -> B
) -> (A?) -> B? {
	return { $0.map(f) }
}

public func map<A, B>(
	_ f: @escaping (A) -> B
) -> (Result<A, Error>) -> Result<B, Error> {
	return { $0.map(f) }
}

public func map<A, B>(
	_ f: @escaping (A) -> B
) -> ([A]) -> [B] {
	return { $0.map(f) }
}

public func map<A, B>(
	_ f: @escaping (A) -> B
) -> (Deferred<A>) -> Deferred<B> {
	return { $0.map(f) }
}

public func map<A, B>(
	_ f: @escaping (A) -> B
) -> (IO<A>) -> IO<B> {
	return { $0.map(f) }
}

public func map<A, B>(
	_ f: @escaping (A) -> B
) -> (Changeable<A>) -> Changeable<B> {
	return { $0.map(f) }
}

public func map<A, B, E>(
	_ f: @escaping (A) -> B
) -> (Reader<E, A>) -> Reader<E, B> {
	return { $0.map(f) }
}

public func map<A, B, S>(
	_ f: @escaping (A) -> B
) -> (State<S, A>) -> State<S, B> {
	return { $0.map(f) }
}

public func map<A, B, M: Monoid>(
	_ f: @escaping (A) -> B
) -> (Writer<A, M>) -> Writer<B, M> {
	return { $0.map(f) }
}

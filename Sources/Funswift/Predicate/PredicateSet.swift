//
//  PredicateSet.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public struct Predicate<A> {
	public let contains: (A) -> Bool
}

// MARK:- anyOf
public func anyOf<A>(
	_ predicate: Predicate<A>...
) -> Predicate<A> {
	Predicate { a in predicate.contains(where: { $0.contains(a) }) }
}

public func anyOf<A>(
	_ predicate: [Predicate<A>]
) -> Predicate<A> {
	Predicate { a in predicate.contains(where: { $0.contains(a) }) }
}

// MARK:- allOf
public func allOf<A>(
	_ predicate: Predicate<A>...
) -> Predicate<A> {
	Predicate { a in predicate.allSatisfy { $0.contains(a) } }
}

public func allOf<A>(
	_ predicate: [Predicate<A>]
) -> Predicate<A> {
	Predicate { a in predicate.allSatisfy { $0.contains(a) } }
}

// MARK:- noneOf
public func noneOf<A>(
	_ predicate: Predicate<A>...
) -> Predicate<A> {
	Predicate { a in !predicate.contains(where: { $0.contains(a) }) }
}

public func noneOf<A>(
	_ predicate: [Predicate<A>]
) -> Predicate<A> {
	Predicate { a in !predicate.contains(where: { $0.contains(a) }) }
}

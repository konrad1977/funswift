//
//  PredicateSet.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public struct Predicate<A> {
	
	public let contains: (A) -> Bool

	public init (contains: @escaping (A) -> Bool) {
		self.contains = contains
	}

	public func contraMap<B>(
		_ f: @escaping (B) -> A
	) -> Predicate<B> {
		Predicate<B> { self.contains(f($0)) }
	}
}

extension Predicate {

	public func union(other: Predicate) -> Predicate {
		Predicate { self.contains($0) || other.contains($0) }
	}

    public func intersect(other: Predicate) -> Predicate {
		Predicate { self.contains($0) && other.contains($0) }
	}

    public func inverted() -> Predicate {
		Predicate { !self.contains($0) }
	}
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

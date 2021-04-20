//
//  Either.swift
//  
//
//  Created by Mikael Konradsson on 2021-04-20.
//

import Foundation

public enum Either<LEFT, B> {

	case left(LEFT)
	case right(B)

	// MARK: - Functor
	public func map<C>(_ f: (B) -> C) -> Either<LEFT, C> {
		switch self {
		case let .left(value):
			return Either<LEFT, C>.left(value)
		case let .right(value):
			return Either<LEFT, C>.right(f(value))
		}
	}

	// MARK: - Monad
	public func flatMap<C>(_ f: (B) -> Either<LEFT, C>) -> Either<LEFT, C> {
		switch self {
		case let .left(value):
			return Either<LEFT, C>.left(value)
		case let .right(value):
			return f(value)
		}
	}
}

// MARK: - Equating
extension Either where B: Equatable { }

// MARK: - Pure
public func pure<A, B>(_ value: B) -> Either<A, B> { .right(value) }


// MARK: - Zip
public func zip<LEFT, A, B>(
	_ lhs: Either<LEFT, A>,
	_ rhs: Either<LEFT, B>)
-> Either<LEFT, (A, B)> {
	switch (lhs, rhs) {
	case let (.right(first), .right(second)):
		return Either<LEFT, (A, B)>.right((first, second))
	case let (_, .left(error)):
		return Either<LEFT, (A, B)>.left(error)
	case let (.left(error), _):
		return Either<LEFT, (A, B)>.left(error)
	}
}


public func zip<LEFT, A, B, C>(
	_ first: Either<LEFT, A>,
	_ second: Either<LEFT, B>,
	_ third: Either<LEFT, C>
) -> Either<LEFT, (A, B, C)> {
	zip(first, zip(second, third))
		.map { ($0, $1.0, $1.1) }
}

public func zip<LEFT, A, B, C, D>(
	_ first: Either<LEFT, A>,
	_ second: Either<LEFT, B>,
	_ third: Either<LEFT, C>,
	_ forth: Either<LEFT, D>
) -> Either<LEFT, (A, B, C, D)> {
	zip(first, zip(second, third, forth))
		.map { ($0, $1.0, $1.1, $1.2) }
}

public func zip<LEFT, A, B, C, D, E>(
	_ first: Either<LEFT, A>,
	_ second: Either<LEFT, B>,
	_ third: Either<LEFT, C>,
	_ forth: Either<LEFT, D>,
	_ fifth: Either<LEFT, E>
) -> Either<LEFT, (A, B, C, D, E)> {
	zip(first, zip(second, third, forth, fifth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3) }
}

public func zip<LEFT, A, B, C, D, E, F>(
	_ first: Either<LEFT, A>,
	_ second: Either<LEFT, B>,
	_ third: Either<LEFT, C>,
	_ forth: Either<LEFT, D>,
	_ fifth: Either<LEFT, E>,
	_ sixth: Either<LEFT, F>
) -> Either<LEFT, (A, B, C, D, E, F)> {
	zip(first, zip(second, third, forth, fifth, sixth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4) }
}

public func zip<LEFT, A, B, C, D, E, F, G>(
	_ first: Either<LEFT, A>,
	_ second: Either<LEFT, B>,
	_ third: Either<LEFT, C>,
	_ forth: Either<LEFT, D>,
	_ fifth: Either<LEFT, E>,
	_ sixth: Either<LEFT, F>,
	_ seventh: Either<LEFT, G>
) -> Either<LEFT, (A, B, C, D, E, F, G)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5) }
}

public func zip<LEFT, A, B, C, D, E, F, G, H>(
	_ first: Either<LEFT, A>,
	_ second: Either<LEFT, B>,
	_ third: Either<LEFT, C>,
	_ forth: Either<LEFT, D>,
	_ fifth: Either<LEFT, E>,
	_ sixth: Either<LEFT, F>,
	_ seventh: Either<LEFT, G>,
	_ eigth: Either<LEFT, H>
) -> Either<LEFT, (A, B, C, D, E, F, G, H)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6) }
}

public func zip<LEFT, A, B, C, D, E, F, G, H, I>(
	_ first: Either<LEFT, A>,
	_ second: Either<LEFT, B>,
	_ third: Either<LEFT, C>,
	_ forth: Either<LEFT, D>,
	_ fifth: Either<LEFT, E>,
	_ sixth: Either<LEFT, F>,
	_ seventh: Either<LEFT, G>,
	_ eigth: Either<LEFT, H>,
	_ ninth: Either<LEFT, I>
) -> Either<LEFT, (A, B, C, D, E, F, G, H, I)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7) }
}

public func zip<LEFT, A, B, C, D, E, F, G, H, I, J>(
	_ first: Either<LEFT, A>,
	_ second: Either<LEFT, B>,
	_ third: Either<LEFT, C>,
	_ forth: Either<LEFT, D>,
	_ fifth: Either<LEFT, E>,
	_ sixth: Either<LEFT, F>,
	_ seventh: Either<LEFT, G>,
	_ eigth: Either<LEFT, H>,
	_ ninth: Either<LEFT, I>,
	_ tenth: Either<LEFT, J>
) -> Either<LEFT, (A, B, C, D, E, F, G, H, I, J)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth, tenth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7, $1.8) }
}


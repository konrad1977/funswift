//
//  Either.swift
//  
//
//  Created by Mikael Konradsson on 2021-04-20.
//

import Foundation

public enum Either<E, B> {

	case left(E)
	case right(B)

	// MARK: - Functor
	public func map<C>(_ f: (B) -> C) -> Either<E, C> {
		switch self {
		case let .left(value):
			return Either<E, C>.left(value)
		case let .right(value):
			return Either<E, C>.right(f(value))
		}
	}

	// MARK: - Monad
	public func flatMap<C>(_ f: (B) -> Either<E, C>) -> Either<E, C> {
		switch self {
		case let .left(value):
			return Either<E, C>.left(value)
		case let .right(value):
			return f(value)
		}
	}

    public init(cathing body: () throws -> B) where E == Error {
        do {
            let result: B = try body()
            self = .right(result)
        } catch {
            self = .left(error)
        }
    }

    public init(result: Result<B, Error>) where E == Error {
        switch result {
        case let .success(value):
            self = .right(value)
        case let .failure(error):
            self = .left(error)
        }
    }
}

// MARK: Values
extension Either {

	public func onRight(_ f: (B) -> Void) -> Self {
		guard case let .right(value) = self
		else { return self }
		f(value)
		return self
	}

	public func onLeft(_ f: (E) -> Void) -> Self {
		guard case let .left(value) = self
		else { return self }
		f(value)
		return self
	}

	public func right() -> B? {
		switch self {
		case let .right(value):
			return value
		case .left:
			return nil
		}
	}

	public func left() -> E? {
		switch self {
		case let .left(value):
			return value
		case .right:
			return nil
		}
	}
}

// MARK: - Equating
extension Either where B: Equatable, E: Equatable { }

// MARK: - Pure
public func pure<A, B>(_ value: B) -> Either<A, B> { .right(value) }


// MARK: - Zip
public func zip<Err, A, B>(
	_ lhs: Either<Err, A>,
	_ rhs: Either<Err, B>)
-> Either<Err, (A, B)> {
	switch (lhs, rhs) {
	case let (.right(first), .right(second)):
		return Either<Err, (A, B)>.right((first, second))
	case let (_, .left(error)):
		return Either<Err, (A, B)>.left(error)
	case let (.left(error), _):
		return Either<Err, (A, B)>.left(error)
	}
}


public func zip<Err, A, B, C>(
	_ first: Either<Err, A>,
	_ second: Either<Err, B>,
	_ third: Either<Err, C>
) -> Either<Err, (A, B, C)> {
	zip(first, zip(second, third))
		.map { ($0, $1.0, $1.1) }
}

public func zip<Err, A, B, C, D>(
	_ first: Either<Err, A>,
	_ second: Either<Err, B>,
	_ third: Either<Err, C>,
	_ forth: Either<Err, D>
) -> Either<Err, (A, B, C, D)> {
	zip(first, zip(second, third, forth))
		.map { ($0, $1.0, $1.1, $1.2) }
}

public func zip<Err, A, B, C, D, E>(
	_ first: Either<Err, A>,
	_ second: Either<Err, B>,
	_ third: Either<Err, C>,
	_ forth: Either<Err, D>,
	_ fifth: Either<Err, E>
) -> Either<Err, (A, B, C, D, E)> {
	zip(first, zip(second, third, forth, fifth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3) }
}

public func zip<Err, A, B, C, D, E, F>(
	_ first: Either<Err, A>,
	_ second: Either<Err, B>,
	_ third: Either<Err, C>,
	_ forth: Either<Err, D>,
	_ fifth: Either<Err, E>,
	_ sixth: Either<Err, F>
) -> Either<Err, (A, B, C, D, E, F)> {
	zip(first, zip(second, third, forth, fifth, sixth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4) }
}

public func zip<Err, A, B, C, D, E, F, G>(
	_ first: Either<Err, A>,
	_ second: Either<Err, B>,
	_ third: Either<Err, C>,
	_ forth: Either<Err, D>,
	_ fifth: Either<Err, E>,
	_ sixth: Either<Err, F>,
	_ seventh: Either<Err, G>
) -> Either<Err, (A, B, C, D, E, F, G)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5) }
}

public func zip<Err, A, B, C, D, E, F, G, H>(
	_ first: Either<Err, A>,
	_ second: Either<Err, B>,
	_ third: Either<Err, C>,
	_ forth: Either<Err, D>,
	_ fifth: Either<Err, E>,
	_ sixth: Either<Err, F>,
	_ seventh: Either<Err, G>,
	_ eigth: Either<Err, H>
) -> Either<Err, (A, B, C, D, E, F, G, H)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6) }
}

public func zip<Err, A, B, C, D, E, F, G, H, I>(
	_ first: Either<Err, A>,
	_ second: Either<Err, B>,
	_ third: Either<Err, C>,
	_ forth: Either<Err, D>,
	_ fifth: Either<Err, E>,
	_ sixth: Either<Err, F>,
	_ seventh: Either<Err, G>,
	_ eigth: Either<Err, H>,
	_ ninth: Either<Err, I>
) -> Either<Err, (A, B, C, D, E, F, G, H, I)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7) }
}

public func zip<Err, A, B, C, D, E, F, G, H, I, J>(
	_ first: Either<Err, A>,
	_ second: Either<Err, B>,
	_ third: Either<Err, C>,
	_ forth: Either<Err, D>,
	_ fifth: Either<Err, E>,
	_ sixth: Either<Err, F>,
	_ seventh: Either<Err, G>,
	_ eigth: Either<Err, H>,
	_ ninth: Either<Err, I>,
	_ tenth: Either<Err, J>
) -> Either<Err, (A, B, C, D, E, F, G, H, I, J)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth, tenth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7, $1.8) }
}


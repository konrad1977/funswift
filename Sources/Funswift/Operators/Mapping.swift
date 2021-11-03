//
//  
//

import Foundation

// MARK:- Map composition
precedencegroup MapCompose { associativity: left higherThan: Pipe }
infix operator <&>: MapCompose

// MARK:- Optionals
public func <&><A, B, C>(
    _ f: @escaping (A) -> Optional<B>,
    _ g: @escaping (B) -> C
) -> (A) -> Optional<C> {
    return { f($0).map(g) }
}

public func <&><A, B>(
	_ lhs: A?,
	_ g: @escaping (A) -> B
) -> B? {
	return { lhs.map(g) }()
}

// MARK:- Result
public func <&><A, B, C>(
    _ f: @escaping (A) -> Result<B, Error>,
    _ g: @escaping (B) -> C
) -> (A) -> Result<C, Error> {
    return { f($0).map(g) }
}

public func <&><A, B>(
	_ lhs: Result<A, Error>,
	_ g: @escaping (A) -> B
) ->  Result<B, Error> {
	return { lhs.map(g) }()
}

// MARK:- Arrays
public func <&><A, B, C>(
    _ f: @escaping (A) -> Array<B>,
    _ g: @escaping (B) -> C
) -> (A) -> Array<C> {
    return { f($0).map(g) }
}

public func <&><A, B>(
	_ lhs: [A],
	_ g: @escaping (A) -> B
) -> [B] {
	return { lhs.map(g) }()
}

// MARK:- Changeable
public func <&><A, B, C>(
    _ f: @escaping (A) -> Changeable<B>,
    _ g: @escaping (B) -> C
) -> (A) -> Changeable<C> {
    return { f($0).map(g) }
}

public func <&><A, B>(
	_ lhs: Changeable<A>,
	_ g: @escaping (A) -> B
) -> Changeable<B> {
	return { lhs.map(g) }()
}

// MARK:- IO
public func <&><A, B, C>(
    _ f: @escaping (A) -> IO<B>,
    _ g: @escaping (B) -> C
) -> (A) -> IO<C> {
    return { f($0).map(g) }
}

public func <&><A, B>(
	_ lhs: IO<A>,
	_ g: @escaping (A) -> B
) -> IO<B> {
	return { lhs.map(g) }()
}

// MARK:- Either
public func <&><A, B, C, E>(
	_ f: @escaping (A) -> Either<E, B>,
	_ g: @escaping (B) -> C
) -> (A) -> Either<E, C> {
	return { f($0).map(g) }
}

public func <&><A, B, E>(
	_ lhs: Either<E, A>,
	_ g: @escaping (A) -> B
) -> Either<E, B> {
	return { lhs.map(g) }()
}

// MARK:- Deferred
public func <&><A, B, C>(
    _ f: @escaping (A) -> Deferred<B>,
    _ g: @escaping (B) -> C
) -> (A) -> Deferred<C> {
    return { f($0).map(g) }
}

public func <&><A, B>(
	_ lhs: Deferred<A>,
	_ g: @escaping (A) -> B
) -> Deferred<B> {
	return { lhs.map(g) }()
}

// MARK:- Reader
public func <&><A, B, C, Environment>(
    _ f: @escaping (A) -> Reader<Environment, B>,
    _ g: @escaping (B) -> C
) -> (A) -> Reader<Environment, C> {
    return { f($0).map(g) }
}

public func <&><A, B, Environment>(
	_ lhs: Reader<Environment, A>,
	_ g: @escaping (A) -> B
) -> Reader<Environment, B> {
	return { lhs.map(g) }()
}

// MARK:- State
public func <&><A, B, C, S>(
    _ f: @escaping (A) -> State<S, B>,
	_ g: @escaping (B) -> C
) -> (A) -> State<S, C> {
    return { f($0).map(g) }
}

public func <&><A, B, S>(
	_ lhs: State<S, A>,
	_ g: @escaping (A) -> B
) -> State<S, B> {
	return { lhs.map(g) }()
}

// MARK: - Cont
public func <&><A, B, C, R>(
    _ f: @escaping (A) -> Cont<B, R>,
    _ g: @escaping (B) -> C
) -> (A) -> Cont<C, R> {
    return { f($0).map(g) }
}

public func <&><A, B, R>(
    _ lhs: Cont<A, R>,
    _ g: @escaping (A) -> B
) -> Cont<B, R> {
    return { lhs.map(g) }()
}

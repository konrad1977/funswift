import Foundation

// MARK: - Bind operator
precedencegroup Bind {
	associativity: left
	higherThan: Pipe, Kleisli
}

infix operator >>-: Bind

// MARK: - Optionals
public func >>- <A, B>(
	_ lhs: A?,
	_ transform: @escaping (A) -> B?
) -> B? {
	lhs.flatMap(transform)
}

// MARK: - Result
public func >>- <A, B, E: Error>(
	_ lhs:  Result<A, E>,
	_ transform: @escaping (A) -> Result<B, E>
) -> Result<B, E> {
	lhs.flatMap(transform)
}

// MARK: - Either
public func >>- <A, B, E>(
	_ lhs:  Either<E, A>,
	_ transform: @escaping (A) -> Either<E, B>
) -> Either<E, B> {
	lhs.flatMap(transform)
}

// MARK: - Changeable
public func >>- <A, B>(
	_ lhs: Changeable<A>,
	_ transform: @escaping (A) -> Changeable<B>
) -> Changeable<B> {
	return lhs.flatMap(transform)
}

// MARK: - IO
public func >>-<A, B>(
	_ lhs: IO<A>,
	_ transform: @escaping (A) -> IO<B>
) -> IO<B> {
	lhs.flatMap(transform)
}

// MARK: - Writer
public func >>-<A, M: Monoid>(
	_ lhs: Writer<A, M>,
	_ transform: @escaping (A) -> Writer<A, M>
) -> Writer<A, M> {
	lhs.flatMap(transform)
}

// MARK: - Deferred
public func >>-<A, B>(
	_ lhs: Deferred<A>,
	_ transform: @escaping (A) -> Deferred<B>
) -> Deferred<B> {
	lhs.flatMap(transform)
}

// MARK: - Reader
public func >>- <A, B, Environment>(
	_ lhs:  Reader<Environment, A>,
	_ transform: @escaping (A) -> Reader<Environment, B>
) -> Reader<Environment, B> {
	lhs.flatMap(transform)
}

// MARK: - State
public func >>- <A, B, S>(
	_ lhs:  State<S, A>,
	_ transform: @escaping (A) -> State<S, B>
) -> State<S, B> {
	lhs.flatMap(transform)
}

// MARK: - Cont
public func >>- <A, B, R>(
    _ lhs:  Cont<A, R>,
    _ transform: @escaping (A) -> Cont<B, R>
) -> Cont<B, R> {
    lhs.flatMap(transform)
}

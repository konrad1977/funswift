import Foundation

// MARK: - Bind operator
precedencegroup Bind {
	associativity: left
	higherThan: Pipe, Fish
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
public func >>- <A, B>(
	_ lhs:  Result<A, Error>,
	_ transform: @escaping (A) -> Result<B, Error>
) -> Result<B, Error> {
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

import Foundation

// MARK: - Bind operator
precedencegroup Bind { associativity: left higherThan: Pipe }
infix operator >>-: Bind

public func >>- <A, B>(
	_ lhs: A?, _ transform: @escaping (A) -> B?
) -> B? {
	lhs.flatMap(transform)
}

public func >>- <A, B>(
	_ lhs: Changeable<A>, _ transform: @escaping (A) -> Changeable<B>
) -> Changeable<B> {
	return lhs.flatMap(transform)
}

public func >>-<A, B>(
	_ lhs: IO<A>, _ transform: @escaping (A) -> IO<B>
) -> IO<B> {
	lhs.flatMap(transform)
}

public func >>-<A, M: Monoid>(
	_ lhs: Writer<A, M>,
	_ transform: @escaping (A) -> Writer<A, M>
) -> Writer<A, M> {
	lhs.flatMap(transform)
}

public func >>- <A, B>(
	_ lhs:  Result<A, Error>,
	_ transform: @escaping (A) -> Result<B, Error>
) -> Result<B, Error> {
	lhs.flatMap(transform)
}

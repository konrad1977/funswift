//
//  Applicative.swift
//  
//
//  Created by Mikael Konradsson on 2021-03-29.
//

import Foundation

precedencegroup ApplicativeFunctor { associativity: left }

infix operator <*>: ApplicativeFunctor

// MARK: - Result Applicative
public func <*><A, B, E: Error>(
	_ lhs: Result<(A) ->B, E>,
	_ rhs: Result<A, E>
) -> Result<B, E> {
	switch (lhs, rhs) {
	case let (.success(functor), .success(value)):
		return .success(functor(value))
	case let (.failure(error), _):
		return .failure(error)
	case let (_, .failure(error)):
		return .failure(error)
	}
}

// MARK: - Either Applicative
public func <*><A, B, LEFT>(
	_ lhs: Either<LEFT, (A) ->B>,
	_ rhs: Either<LEFT, A>
) -> Either<LEFT, B> {
	switch (lhs, rhs) {
	case let (.right(functor), .right(value)):
		return .right(functor(value))
	case let (.left(error), _):
		return .left(error)
	case let (_, .left(error)):
		return .left(error)
	}
}

// MARK: - IO Applicative
public func <*><A, B>(
	_ lhs: IO<(A) ->B>,
	_ rhs: IO<A>
) -> IO<B> {
	rhs.map(lhs.unsafeRun())
}

// MARK: - Deferred Applicative
public func <*><A, B>(
	_ lhs: Deferred<(A) ->B>,
	_ rhs: Deferred<A>
) -> Deferred<B> {

	Deferred<B> { callback in
		lhs.run { functor in
			rhs.map(functor).run { b in
				callback(b)
			}
		}
	}
}

// MARK: - Reader Applicative
public func <*><A, B, Environment>(
	_ lhs: Reader<Environment, (A) -> B>,
	_ rhs: Reader<Environment, A>
) -> Reader<Environment, B> {

	Reader { env in
		let functor = lhs.run(env)
		return rhs.map(functor).run(env)
	}
}

// MARK: - State Applicative
public func <*><A, B, S>(
	_ lhs: State<S, (A) -> B>,
	_ rhs: State<S, A>
) -> State<S, B> {

	State { state in
		let functor = lhs.eval(state: state)
		return rhs.map(functor).run(state: state)
	}
}


// MARK: - Writer Applicative
public func <*><A, B, M: Monoid>(
	_ lhs: Writer<(A) -> B, M>,
	_ rhs: Writer<A, M>
) -> Writer<B, M> {
	let (value, _) = lhs.run()
	return rhs.map(value)
}

// MARK: - Changeable Applicative
public func <*><A, B>(
	_ lhs: Changeable<(A) -> B>,
	_ rhs: Changeable<A>
) -> Changeable<B> {
	rhs.map(lhs.value)
}

// MARK: - Changeable Applicative
public func <*><A, B, R>(
    _ lhs: Cont<(A) -> B, R>,
    _ rhs: Cont<A, R>
) -> Cont<B, R> {
    
    Cont<B, R> { cont in
        lhs.run { innerC in
            rhs.map(innerC).run { result in
                cont(result)
            }
        }
    }
}

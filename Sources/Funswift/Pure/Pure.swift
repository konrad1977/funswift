//
//  Pure.swift
//  
//
//  Created by Mikael Konradsson on 2021-03-23.
//

import Foundation

// MARK: - Deferred<A>
public func pure<A>(_ value: A) -> Deferred<A> {
	Deferred(value)
}

// MARK: - Changeable<A>
public func pure<A>(_ value: A) -> Changeable<A> {
	Changeable(value)
}

// MARK: - State<S, A>
public func pure<A, S>(value: A) -> State<S, A> {
	State(initial: value)
}

// MARK: - Writer<A, M: Monoid>
public func pure<A, M: Monoid>(value: A) -> Writer<A, M> {
	Writer<A, M>(value: value, output: M.empty)
}

// MARK: - Pure IO<A>
public func pure<A>(_ value: A) -> IO<A> {
	IO<A> { value }
}

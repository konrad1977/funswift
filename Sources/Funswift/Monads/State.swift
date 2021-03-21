//
//  State.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public struct State<S, A> {
	
	public let runState: (S) -> (A, S)

	public init(_ f: @escaping (S) -> (A, S)) {
		self.runState = f
	}

	public init(initial: A) {
		runState = { s in (initial, s) }
	}

	public func run(state: S) -> (A, S) {
		runState(state)
	}

	public func eval(state: S) -> A {
		run(state: state).0
	}

	public func map<B>(_ f: @escaping (A) -> B) -> State<S, B> {
		State<S, B> { state in
			let (value, nextState) = run(state: state)
			return (f(value), nextState)
		}
	}

	public func flatMap<B>(_ f: @escaping (A) -> State<S, B>) -> State<S, B> {
		State<S, B> { state in
			let (value, previousState) = run(state: state)
			return f(value).run(state: previousState)
		}
	}

	public func get() -> State<S, S> {
		State<S, S> { s in (s, s) }
	}

	public func set(_ state: S) -> State<S, Void> {
		State<S, Void> { _ in ((), state) }
	}
}

public func pure<A, S>(value: A) -> State<S, A> {
	State(initial: value)
}

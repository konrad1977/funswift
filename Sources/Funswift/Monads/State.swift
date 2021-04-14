//
//  State.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public struct State<S, A> {
	
	public let runState: (S) -> (S, A)

	public init(_ f: @escaping (S) -> (S, A)) {
		self.runState = f
	}

	public init(initialValue: A) {
		runState = { s in (s, initialValue) }
	}

	public func run(state: S) -> (S, A) {
		runState(state)
	}

    public func exec(state: S) -> S {
        run(state: state).0
    }

	public func eval(state: S) -> A {
		run(state: state).1
	}

	public func map<B>(_ f: @escaping (A) -> B) -> State<S, B> {
		State<S, B> { state in
			let (nextState, value) = run(state: state)
			return (nextState, f(value))
		}
	}

	public func flatMap<B>(_ f: @escaping (A) -> State<S, B>) -> State<S, B> {
		State<S, B> { state in
			let (previousState, value) = run(state: state)
			return f(value).run(state: previousState)
		}
	}

	public func get() -> State<S, S> {
		State<S, S> { s in (s, s) }
	}

	public func put(_ state: S) -> State<S, Void> {
		State<S, Void> { _ in (state, ()) }
	}
}

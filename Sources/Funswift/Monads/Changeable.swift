//
//  Changeable.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public struct Changeable<A> {

    public let value: A
    public let hasChanges: Bool

    public func map<B>(_ f: @escaping (A) -> B) -> Changeable<B> {
        Changeable<B>(value: f(value), hasChanges: true)
    }

    public func flatMap<B>(_ f: @escaping (A) -> Changeable<B>) -> Changeable<B> {
        let result = f(value)
        return Changeable<B>(value: result.value, hasChanges: result.hasChanges || hasChanges)
    }

    public init(value: A, hasChanges: Bool) {
        self.value = value
        self.hasChanges = hasChanges
    }
}

public func flatMap<A, B>(
	_ f: @escaping (A) -> Changeable<B>
) -> (Changeable<A>) -> Changeable<B> {
    return { $0.flatMap(f) }
}

public func write<Value: Equatable, Root>(
	_ value: Value,
	at keyPath: WritableKeyPath<Root, Value>
) -> (Root) -> Changeable<Root> {
	return { root in

		guard value != root[keyPath: keyPath]
		else { return Changeable(value: root, hasChanges: false) }

        var copy = root
        copy[keyPath: keyPath] = value
        return Changeable(value: copy, hasChanges: true)
    }
}

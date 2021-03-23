//
//  Writer.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public struct Writer<A, M: Monoid> {

    private let value: A
    private let output: M

    public init(value: A, output: M) {
        self.value = value
        self.output = output
    }

    public func map<B>(_ f: @escaping (A) -> B) -> Writer<B, M> {
        Writer<B, M>(value: f(value), output: output)
    }

    public func flatMap<B>(_ f: @escaping (A) -> Writer<B, M>) -> Writer<B, M> {
        let writer = f(value)
        return Writer<B, M>(value: writer.value, output: output + writer.output)
    }

    public func run() -> (A, M) { (value, output) }
}

extension Writer {

    public static func pure(_ value: A) -> Writer<A, M> {
        Writer(value: value, output: M.empty)
    }

    public static func tell(m: M) -> (A) -> Writer<A, M> {
        return { a in Writer(value: a, output: m) }
    }
}

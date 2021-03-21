//
//  Memoize.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public final class Memoize<A: Hashable, Result> {

    private var memory = [A: Result]()

    public func memoize(_ f: @escaping (A) -> Result) -> (A) -> Result {
        return { a in
            if let result = self.memory[a] {
                return result
            }
            let result = f(a)
            self.memory[a] = result
            return result
        }
    }

    public init() {}
}

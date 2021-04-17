//
//  Operator+pipe.swift
//  
//
//  Created by Mikael Konradsson on 2021-03-21.
//

// MARK:- Pipe
precedencegroup Pipe { associativity: left }
infix operator |>: Pipe

public func |><A, B>(
	_ value: A,
	_ f: @escaping (A) -> B
) -> B {
	return f(value)
}


public func |><A, B>(
    _ value: A,
    _ f: @escaping (inout A) -> B
) -> B {
    var cpy = value
    return f(&cpy)
}

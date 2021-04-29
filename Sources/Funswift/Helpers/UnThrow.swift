//
//  UnThrow.swift
//  
//
//  Created by Mikael Konradsson on 2021-04-29.
//

import Foundation

public func unThrow<A>(
	_ f: @autoclosure () throws -> A
) -> Result<A, Error> {
	Result(catching: f)
}

public func unThrow<A>(
	_ f: () throws -> A
) -> Result<A, Error> {
	Result(catching: f)
}

public func unThrow<A>(
	_ f: @autoclosure () throws -> A
) -> Either<Error, A> {
	Either(cathing: f)
}

public func unThrow<A>(
	_ f: () throws -> A
) -> Either<Error, A> {
	Either(cathing: f)
}

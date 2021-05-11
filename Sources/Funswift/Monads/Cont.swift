//
//  Cont.swift
//  
//
//  Created by Mikael Konradsson on 2021-05-06.
//

import Foundation

public struct Cont<A, R> {

	public typealias Contiuation = (@escaping (A) -> R) -> R

	public let run: Contiuation

	public init(_ run: @escaping Contiuation) {
		self.run = run
	}

	public func map<B>(_ f: @escaping (A) -> B) -> Cont<B, R> {
		Cont<B, R> { callback in self.run { callback(f($0)) } }
	}

	public func flatMap<B>(_ f: @escaping (A) -> Cont<B, R>) -> Cont<B, R> {
		Cont<B, R> { callback in self.run { a in f(a).run(callback) } }
	}
}

extension Cont {
	public static func pure(_ value: A) -> Cont<A, R> {
		Cont { $0(value) }
	}
}

func callCC<A, B, R>(
	_ f: @escaping (_ exit: @escaping (A) -> Cont<B, R>)
	-> Cont<A, R>
) -> Cont<A, R> {
	Cont { outer in
		f { a in
			Cont { _ in
				outer(a)
			}
		}
		.run(outer)
	}
}

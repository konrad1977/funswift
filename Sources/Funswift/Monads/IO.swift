//
//  IO.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public struct IO<A> {

	public let unsafeRun: () -> A

	public init(_ run: @escaping () -> A) {
		self.unsafeRun = run
	}

	public func map<B>(_ f: @escaping (A) -> B) -> IO<B> {
		IO<B> { f(self.unsafeRun()) }
	}

	public func flatMap<B>(_ f: @escaping (A) -> IO<B>) -> IO<B> {
		IO<B> { f(self.unsafeRun()).unsafeRun() }
	}
}

extension IO: Equatable where A: Equatable {
	public static func == (lhs: IO<A>, rhs: IO<A>) -> Bool {
		lhs.unsafeRun() == rhs.unsafeRun()
	}
}

extension IO {

	public static func pure(_ value: A) -> IO<A> {
		IO { value }
	}

    public init(deferred: Deferred<A>) {
        self.init {

            let dispatchGroup = DispatchGroup()
            let queue = DispatchQueue(label: "funswift.deferred.queue")
            var result: A?

            dispatchGroup.enter()
            queue.async(group: dispatchGroup) {
                deferred.run { deferredResult in
                    result = deferredResult
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.wait()
            return result!
        }
    }
}

// MARK: - Zip
public func zip<A, B>(
	_ first: IO<A>,
	_ second: IO<B>
) -> IO<(A, B)> {
	IO { (first.unsafeRun(), second.unsafeRun()) }
}

public func zip<A, B, C>(
	_ first: IO<A>,
	_ second: IO<B>,
	_ third: IO<C>
) -> IO<(A, B, C)> {
	zip(first, zip(second, third))
		.map { ($0, $1.0, $1.1) }
}

public func zip<A, B, C, D>(
	_ first: IO<A>,
	_ second: IO<B>,
	_ third: IO<C>,
	_ forth: IO<D>
) -> IO<(A, B, C, D)> {
	zip(first, zip(second, third, forth))
		.map { ($0, $1.0, $1.1, $1.2) }
}

public func zip<A, B, C, D, E>(
	_ first: IO<A>,
	_ second: IO<B>,
	_ third: IO<C>,
	_ forth: IO<D>,
	_ fifth: IO<E>
) -> IO<(A, B, C, D, E)> {
	zip(first, zip(second, third, forth, fifth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3) }
}

public func zip<A, B, C, D, E, F>(
	_ first: IO<A>,
	_ second: IO<B>,
	_ third: IO<C>,
	_ forth: IO<D>,
	_ fifth: IO<E>,
	_ sixth: IO<F>
) -> IO<(A, B, C, D, E, F)> {
	zip(first, zip(second, third, forth, fifth, sixth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4) }
}

public func zip<A, B, C, D, E, F, G>(
	_ first: IO<A>,
	_ second: IO<B>,
	_ third: IO<C>,
	_ forth: IO<D>,
	_ fifth: IO<E>,
	_ sixth: IO<F>,
	_ seventh: IO<G>
) -> IO<(A, B, C, D, E, F, G)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5) }
}

public func zip<A, B, C, D, E, F, G, H>(
	_ first: IO<A>,
	_ second: IO<B>,
	_ third: IO<C>,
	_ forth: IO<D>,
	_ fifth: IO<E>,
	_ sixth: IO<F>,
	_ seventh: IO<G>,
	_ eigth: IO<H>
) -> IO<(A, B, C, D, E, F, G, H)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6) }
}

public func zip<A, B, C, D, E, F, G, H, I>(
	_ first: IO<A>,
	_ second: IO<B>,
	_ third: IO<C>,
	_ forth: IO<D>,
	_ fifth: IO<E>,
	_ sixth: IO<F>,
	_ seventh: IO<G>,
	_ eigth: IO<H>,
	_ ninth: IO<I>
) -> IO<(A, B, C, D, E, F, G, H, I)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7) }
}

public func zip<A, B, C, D, E, F, G, H, I, J>(
	_ first: IO<A>,
	_ second: IO<B>,
	_ third: IO<C>,
	_ forth: IO<D>,
	_ fifth: IO<E>,
	_ sixth: IO<F>,
	_ seventh: IO<G>,
	_ eigth: IO<H>,
	_ ninth: IO<I>,
	_ tenth: IO<J>
) -> IO<(A, B, C, D, E, F, G, H, I, J)> {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth, tenth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7, $1.8) }
}

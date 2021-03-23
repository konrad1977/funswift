//
//  Deferred.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public struct Deferred<A> {

    public typealias Promise = (@escaping (A) -> Void) -> Void

    public let run: Promise

    public init(_ run: @escaping Promise) {
        self.run = run
    }

	public init(_ work: @autoclosure @escaping () -> A) {
		self = Deferred { callback in
			DispatchQueue.global().async {
				callback(work())
			}
		}
	}

    public func map<B>(_ f: @escaping (A) -> B) -> Deferred<B> {
        Deferred<B> { callback in
            self.run { callback(f($0)) }
        }
    }

    public func flatMap<B>(_ f: @escaping (A) -> Deferred<B>) -> Deferred<B> {
        Deferred<B> { callbackB in
            self.run { f($0).run { callbackB($0) } }
        }
    }
}

extension Deferred {
	
	public static func delayed(by interval: TimeInterval, work: @escaping () -> A ) -> Deferred {
		return Deferred { callback in
			DispatchQueue.global().asyncAfter(deadline: .now() + interval) {
				callback(work())
			}
		}
	}
}

extension Deferred {
	public static func pure(_ value: A) -> Deferred<A> {
		Deferred(value)
	}
}

// MARK:- IO -> Deferred<A>
public func deferred<A>(_ io: IO<A>) -> Deferred<A> {
	Deferred(io.unsafeRun())
}

public func zip<A, B>(
    _ lhs: Deferred<A>,
    _ rhs: Deferred<B>
) -> Deferred<(A, B)> {

    return Deferred<(A, B)> { callback in

        let dispatchGroup = DispatchGroup()
		let queue = DispatchQueue(label: "Deferred.Queue")

        var a: A?
        dispatchGroup.enter()
        lhs.run { resultA in
            a = resultA
            dispatchGroup.leave()
        }

        var b: B?
        dispatchGroup.enter()
        rhs.run { resultB in
            b = resultB
            dispatchGroup.leave()
        }

		dispatchGroup.wait()

        dispatchGroup.notify(queue: queue) {
            if let a = a, let b = b {
                callback((a, b))
            }
        }
    }
}

public func zip<A, B, C>(
    _ first: Deferred<A>,
    _ second: Deferred<B>,
    _ third: Deferred<C>
) -> Deferred<(A, B, C)> {
    zip(first, zip(second, third))
        .map { ($0, $1.0, $1.1) }
}

public func zip<A, B, C, D>(
    _ first: Deferred<A>,
    _ second: Deferred<B>,
    _ third: Deferred<C>,
    _ forth: Deferred<D>
) -> Deferred<(A, B, C, D)> {
    zip(first, zip(second, third, forth))
        .map { ($0, $1.0, $1.1, $1.2) }
}

public func zip<A, B, C, D, E>(
    _ first: Deferred<A>,
    _ second: Deferred<B>,
    _ third: Deferred<C>,
    _ forth: Deferred<D>,
    _ fifth: Deferred<E>
) -> Deferred<(A, B, C, D, E)> {
    zip(first, zip(second, third, forth, fifth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3) }
}

public func zip<A, B, C, D, E, F>(
    _ first: Deferred<A>,
    _ second: Deferred<B>,
    _ third: Deferred<C>,
    _ forth: Deferred<D>,
    _ fifth: Deferred<E>,
    _ sixth: Deferred<F>
) -> Deferred<(A, B, C, D, E, F)> {
    zip(first, zip(second, third, forth, fifth, sixth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4) }
}

public func zip<A, B, C, D, E, F, G>(
    _ first: Deferred<A>,
    _ second: Deferred<B>,
    _ third: Deferred<C>,
    _ forth: Deferred<D>,
    _ fifth: Deferred<E>,
    _ sixth: Deferred<F>,
    _ seventh: Deferred<G>
) -> Deferred<(A, B, C, D, E, F, G)> {
    zip(first, zip(second, third, forth, fifth, sixth, seventh))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5) }
}

public func zip<A, B, C, D, E, F, G, H>(
    _ first: Deferred<A>,
    _ second: Deferred<B>,
    _ third: Deferred<C>,
    _ forth: Deferred<D>,
    _ fifth: Deferred<E>,
    _ sixth: Deferred<F>,
    _ seventh: Deferred<G>,
    _ eigth: Deferred<H>
) -> Deferred<(A, B, C, D, E, F, G, H)> {
    zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6) }
}

public func zip<A, B, C, D, E, F, G, H, I>(
    _ first: Deferred<A>,
    _ second: Deferred<B>,
    _ third: Deferred<C>,
    _ forth: Deferred<D>,
    _ fifth: Deferred<E>,
    _ sixth: Deferred<F>,
    _ seventh: Deferred<G>,
    _ eigth: Deferred<H>,
    _ ninth: Deferred<I>
) -> Deferred<(A, B, C, D, E, F, G, H, I)> {
    zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7) }
}

public func zip<A, B, C, D, E, F, G, H, I, J>(
    _ first: Deferred<A>,
    _ second: Deferred<B>,
    _ third: Deferred<C>,
    _ forth: Deferred<D>,
    _ fifth: Deferred<E>,
    _ sixth: Deferred<F>,
    _ seventh: Deferred<G>,
    _ eigth: Deferred<H>,
    _ ninth: Deferred<I>,
    _ tenth: Deferred<J>
) -> Deferred<(A, B, C, D, E, F, G, H, I, J)> {
    zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth, tenth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7, $1.8) }
}

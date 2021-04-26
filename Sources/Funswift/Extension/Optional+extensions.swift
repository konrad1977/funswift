//
//  Optional+extenions.swift
//
//
//  Created by Mikael Konradsson on 2021-03-24.
//

import Foundation

public func pure<A>(_ value: A) -> Optional<A> { .some(value) }

extension Optional: GenericTypeConstructor {
    typealias ParamtricType = Wrapped
}

public func zip<A, B>(
    _ lhs: Optional<A>,
    _ rhs: Optional<B>)
-> Optional<(A, B)> {

    switch (lhs, rhs) {
    case let (.some(first), .some(second)):
        return .some((first, second))
    case (.none, _):
        return .none
    case (_, .none):
        return .none
    }
}

public func zip<A, B, C>(
    _ first: Optional<A>,
    _ second: Optional<B>,
    _ third: Optional<C>
) -> Optional<(A, B, C)> {
    zip(first, zip(second, third))
        .map { ($0, $1.0, $1.1) }
}

public func zip<A, B, C, D>(
    _ first: Optional<A>,
    _ second: Optional<B>,
    _ third: Optional<C>,
    _ forth: Optional<D>
) -> Optional<(A, B, C, D)> {
    zip(first, zip(second, third, forth))
        .map { ($0, $1.0, $1.1, $1.2) }
}

public func zip<A, B, C, D, E>(
    _ first: Optional<A>,
    _ second: Optional<B>,
    _ third: Optional<C>,
    _ forth: Optional<D>,
    _ fifth: Optional<E>
) -> Optional<(A, B, C, D, E)> {
    zip(first, zip(second, third, forth, fifth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3) }
}

public func zip<A, B, C, D, E, F>(
    _ first: Optional<A>,
    _ second: Optional<B>,
    _ third: Optional<C>,
    _ forth: Optional<D>,
    _ fifth: Optional<E>,
    _ sixth: Optional<F>
) -> Optional<(A, B, C, D, E, F)> {
    zip(first, zip(second, third, forth, fifth, sixth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4) }
}

public func zip<A, B, C, D, E, F, G>(
    _ first: Optional<A>,
    _ second: Optional<B>,
    _ third: Optional<C>,
    _ forth: Optional<D>,
    _ fifth: Optional<E>,
    _ sixth: Optional<F>,
    _ seventh: Optional<G>
) -> Optional<(A, B, C, D, E, F, G)> {
    zip(first, zip(second, third, forth, fifth, sixth, seventh))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5) }
}

public func zip<A, B, C, D, E, F, G, H>(
    _ first: Optional<A>,
    _ second: Optional<B>,
    _ third: Optional<C>,
    _ forth: Optional<D>,
    _ fifth: Optional<E>,
    _ sixth: Optional<F>,
    _ seventh: Optional<G>,
    _ eigth: Optional<H>
) -> Optional<(A, B, C, D, E, F, G, H)> {
    zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6) }
}

public func zip<A, B, C, D, E, F, G, H, I>(
    _ first: Optional<A>,
    _ second: Optional<B>,
    _ third: Optional<C>,
    _ forth: Optional<D>,
    _ fifth: Optional<E>,
    _ sixth: Optional<F>,
    _ seventh: Optional<G>,
    _ eigth: Optional<H>,
    _ ninth: Optional<I>
) -> Optional<(A, B, C, D, E, F, G, H, I)> {
    zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7) }
}

public func zip<A, B, C, D, E, F, G, H, I, J>(
    _ first: Optional<A>,
    _ second: Optional<B>,
    _ third: Optional<C>,
    _ forth: Optional<D>,
    _ fifth: Optional<E>,
    _ sixth: Optional<F>,
    _ seventh: Optional<G>,
    _ eigth: Optional<H>,
    _ ninth: Optional<I>,
    _ tenth: Optional<J>
) -> Optional<(A, B, C, D, E, F, G, H, I, J)> {
    zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth, tenth))
        .map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7, $1.8) }
}

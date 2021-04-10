//
//  
//

import Foundation

// MARK:- Map composition
precedencegroup MapCompose { associativity: left higherThan: Pipe }
infix operator <&>: MapCompose

public func <&> <A, B, C>(
    _ f: @escaping (A) -> B?,
    _ g: @escaping (B) -> C
) -> (A) -> C? {
    return { f($0).map(g) }
}

public func <&> <A, B, C>(
    _ f: @escaping (A) -> Result<B, Error>,
    _ g: @escaping (B) -> C
) -> (A) -> Result<C, Error> {
    return { f($0).map(g) }
}

public func <&> <A, B, C>(
    _ f: @escaping (A) -> [B],
    _ g: @escaping (B) -> C
) -> (A) -> [C] {
    return { f($0).map(g) }
}

public func <&> <A, B, C>(
    _ f: @escaping (A) -> Changeable<B>,
    _ g: @escaping (B) -> C
) -> (A) -> Changeable<C> {
    return { f($0).map(g) }
}

public func <&> <A, B, C>(
    _ f: @escaping (A) -> IO<B>,
    _ g: @escaping (B) -> C
) -> (A) -> IO<C> {
    return { f($0).map(g) }
}

public func <&> <A, B, C>(
    _ f: @escaping (A) -> Deferred<B>,
    _ g: @escaping (B) -> C
) -> (A) -> Deferred<C> {
    return { f($0).map(g) }
}

public func <&> <A, B, C, Environment>(
    _ f: @escaping (A) -> Reader<Environment, B>,
    _ g: @escaping (B) -> C
) -> (A) -> Reader<Environment, C> {
    return { f($0).map(g) }
}

public func <&> <A, B, C, S>(
    _ f: @escaping (A) -> State<S, B>,
    _ g: @escaping (B) -> C
) -> (A) -> State<S, C> {
    return { f($0).map(g) }
}

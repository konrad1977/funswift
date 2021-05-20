//
//  Uncurry.swift
//
//
//  Created by Mikael Konradsson on 2021-04-07.
//

import Foundation

public func uncurry<A, B, Output>(
    _ transform: @escaping (A) -> (B) -> Output
) -> (A, B) -> Output {
    return { a,b in transform(a)(b) }
}

public func uncurry<A, B, C, Output>(
    _ transform: @escaping (A) -> (B) -> (C) -> Output
) -> (A, B, C) -> Output {
    return { a,b,c in transform(a)(b)(c) }
}

public func uncurry<A, B, C, D, Output>(
    _ transform: @escaping (A) -> (B) -> (C) -> (D) -> Output
) -> (A, B, C, D) -> Output {
    return { a,b,c,d in transform(a)(b)(c)(d) }
}

public func uncurry<A, B, C, D, E, Output>(
    _ transform: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> Output
) -> (A, B, C, D, E) -> Output {
    return { a,b,c,d,e in transform(a)(b)(c)(d)(e) }
}

public func uncurry<A, B, C, D, E, F, Output>(
    _ transform: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> Output
) -> (A, B, C, D, E, F) -> Output {
    return { a,b,c,d,e,f in transform(a)(b)(c)(d)(e)(f) }
}

public func uncurry<A, B, C, D, E, F, G, Output>(
    _ transform: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> Output
) -> (A, B, C, D, E, F, G) -> Output {
    return { a,b,c,d,e,f,g in transform(a)(b)(c)(d)(e)(f)(g) }
}

public func uncurry<A, B, C, D, E, F, G, H, Output>(
    _ transform: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (G) -> (H) -> Output
) -> (A, B, C, D, E, F, G, H) -> Output {
    return { a,b,c,d,e,f,g,h in transform(a)(b)(c)(d)(e)(f)(g)(h) }
}

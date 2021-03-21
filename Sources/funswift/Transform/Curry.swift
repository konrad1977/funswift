import Foundation

public func curry<A, B, Output>(
	_ transform: @escaping (A, B) -> Output
) -> (A) -> (B) -> Output {
    return { a in { b in transform(a,b) } }
}

public func curry<A, B, C, Output>(
	_ transform: @escaping (A, B, C) -> Output
) -> (A) -> (B) -> (C) -> Output {
    return { a in { b in { c in transform(a,b,c) } } }
}

public func curry<A, B, C, D, Output>(
	_ transform: @escaping (A, B, C, D) -> Output
) -> (A) -> (B) -> (C) -> (D) -> Output {
    return { a in { b in { c in { d in transform(a,b,c,d) } } } }
}

public func curry<A, B, C, D, E, Output>(
	_ transform: @escaping (A, B, C, D, E) -> Output
) -> (A) -> (B) -> (C) -> (D) -> (E) -> Output {
    return { a in { b in { c in { d in { e in transform(a,b,c,d, e) } } } } }
}

public func curry<A, B, C, D, E, F, Output>(
	_ transform: @escaping (A, B, C, D, E, F) -> Output
) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> Output {
    return { a in { b in { c in { d in { e in { f in transform(a,b,c,d,e,f) } } } } } }
}

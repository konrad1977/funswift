import Foundation

public struct Endo<A>: Monoid {
	
    public static var empty: Endo<A> { Endo<A> { $0 } }
    public let call: (A) -> A

    public init(call: @escaping (A) -> A) {
        self.call = call
    }
}

extension Endo: Semigroup {
    public static func + (lhs: Endo<A>, rhs: Endo<A>) -> Endo<A> {
        return Endo { rhs.call(lhs.call($0)) }
    }
}

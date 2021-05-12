import Foundation

public protocol Semigroup {
    static func + (_ lhs: Self, _ rhs: Self) -> Self
}

extension Numeric where Self: Semigroup {}

extension String: Semigroup {}
extension String.SubSequence: Semigroup { }

extension Array: Semigroup {}

extension Bool: Semigroup {
    public static func + (lhs: Bool, rhs: Bool) -> Bool { lhs && rhs }
}

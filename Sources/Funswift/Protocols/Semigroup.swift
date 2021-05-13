import Foundation

public protocol Semigroup {
    static func + (_ lhs: Self, _ rhs: Self) -> Self
}

//extension Int: Semigroup { }
//extension Double: Semigroup {}
extension Numeric where Self: Semigroup {}

extension String: Semigroup {}
extension String.SubSequence: Semigroup { }

extension Array: Semigroup {}

extension Dictionary: Semigroup {
	public static func + (lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
		var cpy = lhs
		rhs.keys.forEach { key in
			cpy[key] = rhs[key]
		}
		return cpy
	}
}

extension Bool: Semigroup {
    public static func + (lhs: Bool, rhs: Bool) -> Bool { lhs && rhs }
}

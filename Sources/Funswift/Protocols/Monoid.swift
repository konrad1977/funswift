import Foundation

public protocol Monoid: Semigroup {
    static var empty: Self { get }
}

extension String: Monoid {
    public static var empty: String { "" }
}

extension Array: Monoid {
    public static var empty: Array<Element> { [] }
}

extension Bool: Monoid {
    public static var empty: Bool { false }
}

public func concat<M: Monoid>(_ lhs: [M]) -> M {
	lhs.reduce(M.empty, +)
}

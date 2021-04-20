//
//  Array+extensions.swift
//  
//
//  Created by Mikael Konradsson on 2021-04-20.
//

import Foundation

public func pure<A>(_ value: A) -> [A] { [value] }

public func zip<A, B, C>(
	_ first: [A],
	_ second: [B],
	_ third: [C]
) -> [(A, B, C)] {
	zip(first, zip(second, third))
		.map { ($0, $1.0, $1.1) }
}

public func zip<A, B, C, D>(
	_ first: [A],
	_ second: [B],
	_ third: [C],
	_ forth: [D]
) -> [(A, B, C, D)] {
	zip(first, zip(second, third, forth))
		.map { ($0, $1.0, $1.1, $1.2) }
}

public func zip<A, B, C, D, E>(
	_ first: [A],
	_ second: [B],
	_ third: [C],
	_ forth: [D],
	_ fifth: [E]
) -> [(A, B, C, D, E)] {
	zip(first, zip(second, third, forth, fifth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3) }
}

public func zip<A, B, C, D, E, F>(
	_ first: [A],
	_ second: [B],
	_ third: [C],
	_ forth: [D],
	_ fifth: [E],
	_ sixth: [F]
) -> [(A, B, C, D, E, F)] {
	zip(first, zip(second, third, forth, fifth, sixth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4) }
}

public func zip<A, B, C, D, E, F, G>(
	_ first: [A],
	_ second: [B],
	_ third: [C],
	_ forth: [D],
	_ fifth: [E],
	_ sixth: [F],
	_ seventh: [G]
) -> [(A, B, C, D, E, F, G)] {
	zip(first, zip(second, third, forth, fifth, sixth, seventh))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5) }
}

public func zip<A, B, C, D, E, F, G, H>(
	_ first: [A],
	_ second: [B],
	_ third: [C],
	_ forth: [D],
	_ fifth: [E],
	_ sixth: [F],
	_ seventh: [G],
	_ eigth: [H]
) -> [(A, B, C, D, E, F, G, H)] {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6) }
}

public func zip<A, B, C, D, E, F, G, H, I>(
	_ first: [A],
	_ second: [B],
	_ third: [C],
	_ forth: [D],
	_ fifth: [E],
	_ sixth: [F],
	_ seventh: [G],
	_ eigth: [H],
	_ ninth: [I]
) -> [(A, B, C, D, E, F, G, H, I)] {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7) }
}

public func zip<A, B, C, D, E, F, G, H, I, J>(
	_ first: [A],
	_ second: [B],
	_ third: [C],
	_ forth: [D],
	_ fifth: [E],
	_ sixth: [F],
	_ seventh: [G],
	_ eigth: [H],
	_ ninth: [I],
	_ tenth: [J]
) -> [(A, B, C, D, E, F, G, H, I, J)] {
	zip(first, zip(second, third, forth, fifth, sixth, seventh, eigth, ninth, tenth))
		.map { ($0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5, $1.6, $1.7, $1.8) }
}

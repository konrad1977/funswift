//
//  Reader.swift
//  Funswift
//
//  Created by Mikael Konradsson on 2021-03-07.
//

import Foundation

public struct Reader<Environment, Output> {
    public let run: (Environment) -> Output

    public init(run: @escaping (Environment) -> Output) {
        self.run = run
    }

    public func map<B>(_ f: @escaping (Output) -> B) -> Reader<Environment, B> {
        Reader<Environment, B> { r in f(self.run(r)) }
    }

	public func contraMap<B>( _ f: @escaping (B) -> Environment) -> Reader<B, Output> {
		Reader<B, Output> { b in self.run(f(b)) }
	}

    public func flatMap<B>(_ f: @escaping (Output) -> Reader<Environment, B>) -> Reader<Environment, B> {
        Reader<Environment, B> { r in f(self.run(r)).run(r) }
    }
}

public func zip<Environment, A, B>(
    _ first: Reader<Environment, A>,
    _ second: Reader<Environment, B>
) -> Reader<Environment, (A, B)> {
    Reader { environment in (first.run(environment), second.run(environment)) }
}

public func zip<Envrionment, A, B, C>(
    _ fst: Reader<Envrionment, A>,
    _ snd: Reader<Envrionment, B>,
    _ trd: Reader<Envrionment, C>
) -> Reader<Envrionment, (A, B, C)> {
    zip(fst, zip(snd, trd)).map { ($0.0, $0.1.0, $0.1.1) }
}

public func zip<Envrionment, A, B, C, D>(
    _ fst: Reader<Envrionment, A>,
    _ snd: Reader<Envrionment, B>,
    _ trd: Reader<Envrionment, C>,
    _ frth: Reader<Envrionment, D>
) -> Reader<Envrionment, (A, B, C, D)> {
    zip(fst, zip(snd, trd, frth))
        .map { ($0.0, $0.1.0, $0.1.1, $0.1.2) }
}

public func zip<Environment, A, B, C, D, E>(
    _ fst: Reader<Environment, A>,
    _ snd: Reader<Environment, B>,
    _ trd: Reader<Environment, C>,
    _ frth: Reader<Environment, D>,
    _ fifth: Reader<Environment, E>
) -> Reader<Environment, (A, B, C, D, E)> {
    zip(fst, zip(snd, trd, frth, fifth))
        .map { ($0.0, $0.1.0, $0.1.1, $0.1.2, $0.1.3) }
}

public func zip<Environment, A, B, C, D, E, F>(
    _ fst: Reader<Environment, A>,
    _ snd: Reader<Environment, B>,
    _ trd: Reader<Environment, C>,
    _ frth: Reader<Environment, D>,
    _ fifth: Reader<Environment, E>,
    _ sixth: Reader<Environment, F>
) -> Reader<Environment, (A, B, C, D, E, F)> {
    zip(fst, zip(snd, trd, frth, fifth, sixth))
        .map { ($0.0, $0.1.0, $0.1.1, $0.1.2, $0.1.3, $0.1.4) }
}

public func zip<Environment, A, B, Output>(
    with f: @escaping (A, B) -> Output,
    _ lhs: Reader<Environment, A>,
    _ rhs: Reader<Environment, B>
) -> Reader<Environment, Output> {
    zip(lhs, rhs).map(f)
}

public func zip<Environment, A, B, C, Output>(
    with f: @escaping (A, B, C) -> Output,
    _ first: Reader<Environment, A>,
    _ second: Reader<Environment, B>,
    _ third: Reader<Environment, C>
) -> Reader<Environment, Output> {
    zip(first, second, third).map(f)
}

public func zip<Environment, A, B, C, D, Output>(
    with f: @escaping (A, B, C, D) -> Output,
    _ first: Reader<Environment, A>,
    _ second: Reader<Environment, B>,
    _ third: Reader<Environment, C>,
    _ forth: Reader<Environment, D>
) -> Reader<Environment, Output> {
    zip(first, second, third, forth).map(f)
}

public func zip<Environment, A, B, C, D, E, Output>(
    with f: @escaping (A, B, C, D, E) -> Output,
    _ first: Reader<Environment, A>,
    _ second: Reader<Environment, B>,
    _ third: Reader<Environment, C>,
    _ forth: Reader<Environment, D>,
    _ fifth: Reader<Environment, E>
) -> Reader<Environment, Output> {
    zip(first, second, third, forth, fifth).map(f)
}

public func zip<Environment, A, B, C, D, E, F, Output>(
    with f: @escaping (A, B, C, D, E, F) -> Output,
    _ first: Reader<Environment, A>,
    _ second: Reader<Environment, B>,
    _ third: Reader<Environment, C>,
    _ forth: Reader<Environment, D>,
    _ fifth: Reader<Environment, E>,
    _ sixth: Reader<Environment, F>
) -> Reader<Environment, Output> {
    zip(first, second, third, forth, fifth, sixth).map(f)
}

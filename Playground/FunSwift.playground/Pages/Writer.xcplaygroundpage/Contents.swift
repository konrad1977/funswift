//: [Previous](@previous)

import Foundation
import Funswift

func half(_ value: Int) -> Writer<Int, [String]> {
	Writer(value: value / 2, output: [
			"Turning \(value) in to half \(value / 2)"
	])
}

func incrWith(_ incr: Int) -> (Int) -> Writer<Int, [String]> {
	return { value in
		Writer(value: value + incr, output: ["Incr \(value) with \(incr)"])
	}
}

func incr(_ value: Int) -> Writer<Int, [String]> {
	Writer(value: value + 1, output: ["Incr \(value) with 1"])
}

let writer = half(8) >>- incrWith(20)
let (result, logs) = writer.run()

result
logs

// alternative syntax
let (res, log) =
	half(8)
	.flatMap(incrWith(20))
	.run()

//: [Next](@next)

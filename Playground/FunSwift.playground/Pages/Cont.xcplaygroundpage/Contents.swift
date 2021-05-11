//: [Previous](@previous)

import Foundation
import Funswift
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func upperCased(_ str: String) -> String { str.uppercased() }
func value(val: Int) -> String { String(val) }

print(Cont.delayed(by: 2, value: "Hello").run(upperCased))
Cont { $0(10) }.run(value)


//: [Next](@next)

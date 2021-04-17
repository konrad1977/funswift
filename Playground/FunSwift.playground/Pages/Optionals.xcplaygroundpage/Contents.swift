//: [Previous](@previous)

import Foundation
import Funswift

let mabyeInt: Int? = nil

zip(pure(10), 10)
zip(pure(10), 10, mabyeInt)

zip(pure(10), 10, "Third")
zip(pure(10), 10, mabyeInt, "Forth")


zip(10, 10, 10, 10, 10, 10, 10, 10, 10)
zip(10, 10, 10, 10, 10, 10, Optional<Int>.none, 10, 10)

//: [Next](@next)

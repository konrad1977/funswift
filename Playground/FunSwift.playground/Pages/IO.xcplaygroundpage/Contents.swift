//: [Previous](@previous)

import Foundation
import Funswift

let lazyHelloWorld = IO<String> { "Hello world" }

lazyHelloWorld
	.unsafeRun()


//: [Next](@next)

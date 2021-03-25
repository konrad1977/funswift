//: [Previous](@previous)

import Foundation
import Funswift

extension String: Error {}

func validate(value: Int) -> Result<Int, String> {
	value < 10
		? .success(value)
		: .failure("Cannot be higher than 9")
}

func multiplyByTen(value: Int) -> Result<Int, String> {
	value != 0
		? .success(value * 10)
		: .failure("Cannot multiply by 0")
}

func toString(value: Int) -> Result<String, String> {
	.success(String(value))
}


validate(value: 1)
	.flatMap(multiplyByTen)
	.flatMap(toString)
	.onFailure { print("error: \($0)") }
	.onSuccess { print("\($0)") }

zip(
	multiplyByTen(value: 8),
	validate(value: 8)
).flatMap { first, second in
	return .success("\(first + second)")
}
.onSuccess { print("Result: \($0)") }
.onFailure { print("Failed: \($0)") }


//: [Next](@next)

import XCTest
@testable import Funswift

extension String: Error {}

final class OperatorKleisli: XCTestCase {

	func incr(_ value: Int?) -> Int? {
		guard let value = value
		else { return nil }

		return value + 1
	}

	func incrValidation(_ value: Int) -> Result<Int, Error> {
		value < 0 ? .failure("Not valid") : .success(value + 1)
	}

	func testOptionalComposition() {
		let increaseTwice = incr >=> incr

		let result = increaseTwice(nil)
		XCTAssertNil(result)

		let first: Int? = 10
		let secondResult = increaseTwice(first)
		XCTAssertEqual(12, secondResult)

		XCTAssertEqual(22, 20 |> incr >=> incr)
	}

	func testResultComposition() {
		let result = 10 |> incrValidation >=> incrValidation

		XCTAssertEqual(12, try result.get())
	}
}

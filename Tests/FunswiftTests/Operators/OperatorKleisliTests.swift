import XCTest
@testable import Funswift

final class OperatorKleisli: XCTestCase {

	func incr(_ value: Int?) -> Int? {
		guard let value = value
		else { return nil }

		return value + 1
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
}

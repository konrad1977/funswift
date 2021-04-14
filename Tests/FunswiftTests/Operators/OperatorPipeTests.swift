import XCTest
@testable import Funswift

final class OperatorPipe: XCTestCase {

	func incr(_ value: Int) -> Int { value + 1 }
	func incr(_ value: IO<Int>) -> IO<Int> {
		value.map(incr)
	}

	func testIncreaseValue() {
		let result = 10 |> incr
		XCTAssertEqual(11, result)
	}

	func testPipeIO() {
		let result = IO { 10 } |> incr
		XCTAssertEqual(11, result.unsafeRun())
	}
}

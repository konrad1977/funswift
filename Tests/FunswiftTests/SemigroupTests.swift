import XCTest
@testable import Funswift

final class SemigroupTests: XCTestCase {

	func incr(_ val: inout Int) -> Void { val += 1 }
	func multiply(_ val: inout Int) -> Void { val *= val }

	func testSemigroupArray() {
		let result = [1,3,4] <> [2,3,4]
		XCTAssertEqual([1,3,4,2,3,4], result)
	}

	func testSemigroupString() {
		let result = "Hello" <> " world"
		XCTAssertEqual("Hello world", result)
	}

	func testSemigroupBool() {
		XCTAssertEqual(true, true <> true)
		XCTAssertEqual(false, true <> false)
		XCTAssertEqual(false, false <> true)
		XCTAssertEqual(false, false <> false)
	}

	func testSemigroupFunctions() {

		let incr: (Int) -> Int = { $0 + 1 }
		let multiply: (Int) -> Int = { $0 * $0 }

		let multiplyAndInreament = multiply <> incr
		XCTAssertEqual(101, multiplyAndInreament(10))
	}

	func testInoutFunctions() {
		var value: Int = 10
		let multiplyAndInreament = multiply <> incr
		multiplyAndInreament(&value)
		XCTAssertEqual(101, value)
	}

	func testSemigroupReferenceType() {

		let uppercasedStyle: (UILabel) -> Void = { $0.text = $0.text?.uppercased() }
		let rightAlignStyle: (UILabel) -> Void = { $0.textAlignment = .right }
		let label = UILabel()
		label.text = "Hello World"

		let uppercasedRightAlignStyle = uppercasedStyle <> rightAlignStyle
		uppercasedRightAlignStyle(label)

		XCTAssertEqual("HELLO WORLD", label.text)
		XCTAssertEqual(.right, label.textAlignment)
	}
}

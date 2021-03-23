import XCTest
@testable import Funswift

final class IOTests: XCTestCase {

	func testMap() {

		let result = IO<Int> { 10 }
			.map(String.init)
			.unsafeRun()

		XCTAssertEqual("10", result)
	}

	func testFlatMap() {

		let multiplyWithHundred: (Int) -> IO<Int> = { number in IO { number * 100 } }

		let result = IO<Int> { 10 }
			.flatMap(multiplyWithHundred)
			.flatMap(multiplyWithHundred)
			.flatMap(multiplyWithHundred)
			.unsafeRun()

		XCTAssertEqual(10000000, result)
	}

	func testBind() {

		let multiplyWithHundred: (Int) -> IO<Int> = { number in IO { number * 100 } }

		let result = IO<Int> { 10 }
			>>- multiplyWithHundred
			>>- multiplyWithHundred
			>>- multiplyWithHundred

		XCTAssertEqual(10000000, result.unsafeRun())
	}

	func testPure() {
		let result = pure(10).unsafeRun()
		XCTAssertEqual(10, result)

		let resultB = pure(100).unsafeRun()
		XCTAssertEqual(100, resultB)
	}

	func testZip() {

		let result = zip(
			pure(10),
			pure(100.0),
			IO { 20 },
			IO { "Hello world" },
			IO { "Boom" }
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
		XCTAssertEqual(20, result.2)
		XCTAssertEqual("Hello world", result.3)
		XCTAssertEqual("Boom", result.4)
	}
}

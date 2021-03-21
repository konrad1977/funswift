import XCTest
@testable import Funswift

final class IOTests: XCTestCase {

	func testMapIO() {

		let result = IO<Int> { 10 }
			.map(String.init)
			.unsafeRun()

		XCTAssertEqual("10", result)
	}

	func testFlatMapIO() {

		let multiplyWithHundred: (Int) -> IO<Int> = { number in IO { number * 100 } }

		let result = IO<Int> { 10 }
			.flatMap(multiplyWithHundred)
			.flatMap(multiplyWithHundred)
			.flatMap(multiplyWithHundred)
			.unsafeRun()

		XCTAssertEqual(10000000, result)
	}

	func testBindIO() {

		let multiplyWithHundred: (Int) -> IO<Int> = { number in IO { number * 100 } }

		let result = IO<Int> { 10 }
			>>- multiplyWithHundred
			>>- multiplyWithHundred
			>>- multiplyWithHundred

		XCTAssertEqual(10000000, result.unsafeRun())
	}

	func testPureIO() {
		let result = pure(10).unsafeRun()
		XCTAssertEqual(10, result)

		let resultB = IO.pure(100).unsafeRun()
		XCTAssertEqual(100, resultB)
	}

	func testZipIO() {

		let result = zip(
			pure(10),
			IO.pure(100.0),
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

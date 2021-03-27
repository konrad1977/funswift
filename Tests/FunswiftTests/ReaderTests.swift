import XCTest
@testable import Funswift

final class ReaderTests: XCTestCase {

	func testSimpleRun() {
		let reader = Reader<Int, String> { number in String.init(number) }
			.run(10)
		XCTAssertEqual(reader, "10")
	}

	func testReturnValue() {
		let reader = Reader<Int, Int> { $0 }
			.run(100)
		XCTAssertEqual(reader, 100)
	}

	func testMap() {
		let reader = Reader<Int, Int> { $0 }
			.map(String.init)
			.run(100)
		XCTAssertEqual(reader, "100")
	}
}

import XCTest
@testable import Funswift

final class ContTests: XCTestCase {

	func doubleMe(_ value: Double) -> Double { value * 2 }

	func testPure() {
		let result = Cont<Double, Double>
			.pure(10.2)

		XCTAssertEqual(20.4, result.run(doubleMe))
	}

	func testMapPure() {
		let result = Cont { $0(100) }
			.map { Double($0) }
			.run(doubleMe)

		XCTAssertEqual(200, result)
	}
}

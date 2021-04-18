import XCTest
@testable import Funswift

final class FunctorLawsTests: XCTestCase {

	func testIdentityIO() {
		let result = IO { 10 } <&> identity
		XCTAssertEqual(10, result.unsafeRun())

		let result2 = IO { 10 }.map(identity)
		XCTAssertEqual(10, result2.unsafeRun())
	}

	func testIdentityDeferred() {

		let firstDeferred = Deferred(10) <&> identity
		let secondDeferred = Deferred(10).map(identity)

		let firstExpectation = XCTestExpectation(description: "Deferred wait first")
		let secondExpectation = XCTestExpectation(description: "Deferred wait second")

		firstDeferred.run { result in
			XCTAssertEqual(10, result)
			firstExpectation.fulfill()
		}

		secondDeferred.run { result in
			XCTAssertEqual(10, result)
			secondExpectation.fulfill()
		}

		wait(for: [firstExpectation, secondExpectation], timeout: 0.1)
	}
}

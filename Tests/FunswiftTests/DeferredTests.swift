import XCTest
@testable import Funswift

final class DeferredTests: XCTestCase {

	func testDelayed() {

		let expectation = XCTestExpectation(description: "Waiting")

		let result = Deferred.delayed(by: 1) { 10 }

		result.run { value in
			XCTAssertEqual(10, value)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 2)
	}

	func testMap() {

		let expectation = XCTestExpectation(description: "Waiting")

		let result = Deferred { callback in callback(10) }
			.map(String.init)

		result.run { value in
			XCTAssertEqual("10", value)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 2)
	}

	func testZip() {

		let expectation = XCTestExpectation(description: "Waiting")

		let result = zip(
			Deferred { $0(10) },
			Deferred.delayed(by: 2) { 10 },
			Deferred.delayed(by: 1) { 10.2 },
			Deferred.delayed(by: 3) { "Hello world" },
			Deferred { $0("Hello Callback") }
		)
		result.run { first, second, third, forth, fifth in
			XCTAssertEqual(10, first)
			XCTAssertEqual(10, second)
			XCTAssertEqual(10.2, third)
			XCTAssertEqual("Hello world", forth)
			XCTAssertEqual("Hello Callback", fifth)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 3.1)
	}

    func testInitFromIO() {

        let expectation = XCTestExpectation(description: "Waiting")

        let result = zip(
            Deferred { $0(10) },
            Deferred(io: IO { 10 })
        )

        result.run { first, second in
            XCTAssertEqual(10, first)
            XCTAssertEqual(10, second)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
    }
}

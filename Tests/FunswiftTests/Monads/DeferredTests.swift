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
        wait(for: [expectation], timeout: 1.1)
	}

    func testDelayedIO() {

        let expectation = XCTestExpectation(description: "Waiting")

        let result = Deferred.delayed(by: 1, withIO: IO { 10 })

        result.run { value in
            XCTAssertEqual(10, value)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.1)
    }

    func testInitFromIO() {

        let expectation = XCTestExpectation(description: "Waiting")

        let result = zip(
            Deferred(10),
            Deferred(io: IO { 10 })
        )

        result.run { first, second in
            XCTAssertEqual(10, first)
            XCTAssertEqual(10, second)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
    }

	func testMap() {

		let expectation = XCTestExpectation(description: "Waiting")

		let result = Deferred(10)
			.map(String.init)

		result.run { value in
			XCTAssertEqual("10", value)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 2)
	}

    func testZip2() {

        let expectation = XCTestExpectation(description: "Waiting")

        let result = zip(
            Deferred { $0(10) },
            Deferred.delayed(by: 1) { "Hello world" }
        )
        result.run { first, second in
            XCTAssertEqual(10, first)
            XCTAssertEqual("Hello world", second)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.1)
    }

    func testZip3() {

        let expectation = XCTestExpectation(description: "Waiting")

        let result = zip(
            Deferred { $0(10) },
            Deferred.delayed(by: 1) { "Hello world" },
            Deferred { $0(10.2) }
        )
        result.run { first, second, third in
            XCTAssertEqual(10, first)
            XCTAssertEqual("Hello world", second)
            XCTAssertEqual(10.2, third)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.1)
    }

    func testZip4() {

        let expectation = XCTestExpectation(description: "Waiting")

        let result = zip(
            Deferred { $0(10) },
            Deferred.delayed(by: 1) { "Hello world" },
            Deferred { $0(10.2) },
            Deferred.delayed(by: 1) { URL.init(string: "http://www.google.com" ) }
        )

        result.run { first, second, third, forth in
            XCTAssertEqual(10, first)
            XCTAssertEqual("Hello world", second)
            XCTAssertEqual(10.2, third)
            XCTAssertNotNil(forth, "Shouldnt be nil")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.1)
    }

	func testZip5() {

		let expectation = XCTestExpectation(description: "Waiting")

		let result = zip(
			Deferred { $0(10) },
            Deferred.delayed(by: 0.7) { 10 },
            Deferred.delayed(by: 0.5) { 10.2 },
            Deferred.delayed(by: 0.9) { "Hello world" },
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
		wait(for: [expectation], timeout: 1)
	}

    func testZip6() {

        let expectation = XCTestExpectation(description: "Waiting")

        let result = zip(
            Deferred { $0(10) },
            Deferred.delayed(by: 0.3) { 10 },
            Deferred.delayed(by: 0.2) { 10.2 },
            Deferred.delayed(by: 0.3) { "Hello world" },
            Deferred { $0("Hello Callback") },
            Deferred(io: IO { 101 })
        )
        result.run { first, second, third, forth, fifth, sixth in
            XCTAssertEqual(10, first)
            XCTAssertEqual(10, second)
            XCTAssertEqual(10.2, third)
            XCTAssertEqual("Hello world", forth)
            XCTAssertEqual("Hello Callback", fifth)
            XCTAssertEqual(101, sixth)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.31)
    }

    func testZip7() {

        let expectation = XCTestExpectation(description: "Waiting")

        let result = zip(
            Deferred { $0(10) },
            Deferred.delayed(by: 0.2) { 10 },
            Deferred.delayed(by: 0.3) { 10.2 },
            Deferred.delayed(by: 0.5) { "Hello world" },
            Deferred { $0("Hello Callback") },
            Deferred(io: IO { 101 })
        )
        result.run { first, second, third, forth, fifth, sixth in
            XCTAssertEqual(10, first)
            XCTAssertEqual(10, second)
            XCTAssertEqual(10.2, third)
            XCTAssertEqual("Hello world", forth)
            XCTAssertEqual("Hello Callback", fifth)
            XCTAssertEqual(101, sixth)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.55)
    }

	func testInitPureTResult() {
		let expectation = XCTestExpectation(description: "Waiting")

		let result = Deferred<Result<Int, Error>>.pureT(10)
		result.run { result in
			expectation.fulfill()
			XCTAssertEqual(10, try! result.get())
		}

		wait(for: [expectation], timeout: 0.55)
	}

	func testInitPureTOptional() {
		
		let expectation = XCTestExpectation(description: "Waiting")

		let result = Deferred<Optional<Int>>.pureT(10)
		result.run { result in
			expectation.fulfill()
			XCTAssertEqual(10, result)
		}

		wait(for: [expectation], timeout: 0.55)
	}

    func testCancelation() {
        let expectation = XCTestExpectation(description: "Waiting")
        var result = Deferred.delayed(by: 0.8) { 10 }

        result.onCancel = {
            expectation.fulfill()
        }
        result.cancel()

        wait(for: [expectation], timeout: 1)
    }

	func testAnyCanceableDeferred() {
		
        var deferredWithInt = Deferred.delayed(by: 0.1) { 10 }
            .map(String.init)
        
		var deferredWithString = Deferred.delayed(by: 0.1) { "Hello World" }

		let expectationInt = XCTestExpectation(description: "WaitingInt")
		let expectationString = XCTestExpectation(description: "WaitingString")

        deferredWithInt.onCancel = {
            expectationInt.fulfill()
        }

        deferredWithString.onCancel = {
            expectationString.fulfill()
        }

		let canceable: [AnyCancellableDeferred] = [deferredWithInt, deferredWithString]
		canceable.forEach { $0.cancel() }

		wait(for: [expectationInt, expectationString], timeout: 2)
	}

    func testCancelZip() {

        var deferredWithInt = Deferred
            .delayed(by: 0.1) { 10 }
            .map(String.init)

        var deferredWithString = Deferred
            .delayed(by: 0.1) { "Hello World" }

        let expectationInt = XCTestExpectation(description: "WaitingInt")
        let expectationString = XCTestExpectation(description: "WaitingString")

        deferredWithInt.onCancel = {
            print("Cancel first")
            expectationInt.fulfill()
        }

        deferredWithString.onCancel = {
            print("cancel second")
            expectationString.fulfill()
        }

        let newResult = zip(deferredWithInt, deferredWithString)
        newResult.cancel()

        debugPrint(newResult)

        wait(for: [expectationInt, expectationString], timeout: 2)
    }

    func testCancelThenMap() {

        var deferredWithInt = Deferred
            .delayed(by: 0.1) { 10 }
            .map(String.init)

        let expectation = XCTestExpectation(description: "WaitingInt")

        deferredWithInt.onCancel = {
            expectation.fulfill()
        }

        deferredWithInt.cancel()
        debugPrint(deferredWithInt)
        wait(for: [expectation], timeout: 1)
    }
}

import XCTest
@testable import Funswift

final class OperatorPipe: XCTestCase {

	func incr(_ value: Int) -> Int { value + 1 }

	func incr(_ value: IO<Int>) -> IO<Int> { value.map(incr) }
    func incr(_ value: Deferred<Int>) -> Deferred<Int> { value.map(incr) }
    func incr(_ value: Changeable<Int>) -> Changeable<Int> { value.map(incr) }


	func testIncreaseValue() {
		let result = 10 |> incr
		XCTAssertEqual(11, result)
	}

	func testPipeIO() {
		let result = IO { 10 } |> incr
		XCTAssertEqual(11, result.unsafeRun())
	}

    func testPipeChangeable() {
        let result = Changeable(10) |> incr
        XCTAssertEqual(11, result.value)

    }

    func testPipeDeferred() {

        let deferred = Deferred(10) |> incr

        let expectation = XCTestExpectation(description: "Deferred")

        deferred.run { result in
            expectation.fulfill()
            XCTAssertEqual(11, result)

        }
        wait(for: [expectation], timeout: 0.1)
    }
}

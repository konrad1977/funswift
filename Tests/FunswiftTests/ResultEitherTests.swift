import XCTest
@testable import Funswift

final class ResultEitherTests: XCTestCase {

	enum TestError: Error {
		case customError
	}

	func testResultFromEitherHappyPath() {
		let either: Either<Error, String> = .right("Hello world")
		let result = Result(either: either)

		XCTAssertEqual(try result.get(), "Hello world")
		XCTAssertEqual(try result.get(), either.right())

	}

	func testResultFromEitherSadPath() {
		let either: Either<Error, String> = .left(TestError.customError)
		let result = Result(either: either)

		switch result {
		case let .failure(error):
			XCTAssertTrue(
				error is TestError,
				"Unexpected error type: \(type(of: error))"
			)
		case .success:
			XCTAssertFalse(true)
		}
	}

	func testEitherFromResultHappyPath() {
		let result: Result<String, Error> = .success("Hello world")
		let either = Either(result: result)

		XCTAssertEqual(try result.get(), either.right())
		XCTAssertEqual("Hello world", either.right())
	}

	func testEitherFromResultSadPath() {
		let result: Result<String, Error> = .failure(TestError.customError)
		let either = Either(result: result)

		XCTAssertTrue(either.left() is TestError)
	}
}

import XCTest
@testable import Funswift

final class EitherTests: XCTestCase {

	enum CustomError: Error {
		case testError
	}

	func testFunctor() {
		let either: Either<Error, String> = .right("Hello world")
		XCTAssertEqual("HELLO WORLD", either.map { $0.uppercased() }.right())
		XCTAssertTrue(either.isRight())
	}

	func testBiFunctor() {
		let either: Either<String, String> = .left("wrong")
		XCTAssertEqual("WRONG", either.biMap({ $0.uppercased() }, { $0.uppercased() }).left())
		XCTAssertTrue(either.isLeft())
		XCTAssertFalse(either.isRight())
	}

	func testLMapFunctor() {
		let either: Either<String, String> = .left("wrong")
		XCTAssertEqual("WRONG", either.lMap({ $0.uppercased() }).left())
		XCTAssertTrue(either.isLeft())
		XCTAssertFalse(either.isRight())
	}


}



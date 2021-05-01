import XCTest
@testable import Funswift

final class EitherTests: XCTestCase {

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

	func testBiFunctorIdentity() {
		let either: Either<String, String> = .left("_wrong_")
		XCTAssertEqual("_wrong_", either.biMap(identity, identity).left())
		XCTAssertTrue(either.isLeft())
		XCTAssertFalse(either.isRight())
	}

	func testLMapFunctor() {
		let either: Either<String, String> = .left("wrong")
		XCTAssertEqual("WRONG", either.lMap({ $0.uppercased() }).left())
		XCTAssertTrue(either.isLeft())
		XCTAssertFalse(either.isRight())
	}

	func testOnLeft() {
		let either: Either<String, String> = .left("wrong")

		either
			.onLeft { str in XCTAssertEqual(str, "wrong") }
			.onRight { _ in XCTAssertTrue(false) }
	}

	func testOnRight() {
		let either: Either<String, String> = .right("right")

		either
			.onLeft { _ in XCTAssertTrue(false) }
			.onRight { XCTAssertEqual("right", $0) }
	}
}



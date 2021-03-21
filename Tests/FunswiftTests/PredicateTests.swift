import XCTest
@testable import Funswift

final class PredicateTests: XCTestCase {

	func testEmptyReturningPredicates() {

		let alwaysTrue = Predicate<Int> { _ in true }
		let alwaysFalse = Predicate<Int> { _ in false }

		XCTAssertTrue(alwaysTrue.contains(0), "Always true")
		XCTAssertFalse(alwaysFalse.contains(0), "Always false")
	}

	func testAllOfVariadic() {

		XCTAssertTrue(
			allOf(
				Predicate<Int> { _ in true },
				Predicate<Int> { _ in true },
				Predicate<Int> { _ in true }
			).contains(0), "Should be true true"
		)

		XCTAssertFalse(
			allOf(
				Predicate<Int> { _ in true },
				Predicate<Int> { _ in false },
				Predicate<Int> { _ in true }
			).contains(0), "Should be false"
		)
	}

	func testAllOfArray() {

		XCTAssertTrue(
			allOf(
				[
					Predicate<Int> { _ in true },
					Predicate<Int> { _ in true },
					Predicate<Int> { _ in true }
				]
			).contains(0), "Should be true"
		)

		XCTAssertFalse(
			allOf(
				[
					Predicate<Int> { _ in true },
					Predicate<Int> { _ in false },
					Predicate<Int> { _ in true }
				]
			).contains(0), "Should be false"
		)
	}

	func testAnyOfArray() {

		XCTAssertTrue(
			anyOf(
				[
					Predicate<Int> { _ in true },
					Predicate<Int> { _ in false },
					Predicate<Int> { _ in false }
				]
			).contains(0), "Should be true"
		)

		XCTAssertFalse(
			anyOf(
				[
					Predicate<Int> { _ in false },
					Predicate<Int> { _ in false },
					Predicate<Int> { _ in false }
				]
			).contains(0), "Should be false"
		)
	}

	func testAnyOfVariadic() {

		XCTAssertTrue(
			anyOf(
				Predicate<Int> { _ in true },
				Predicate<Int> { _ in false },
				Predicate<Int> { _ in false }
			).contains(0), "Should be true"
		)

		XCTAssertFalse(
			anyOf(
				Predicate<Int> { _ in false },
				Predicate<Int> { _ in false },
				Predicate<Int> { _ in false }
			).contains(0), "Should be false"
		)
	}

	func testNoneOfVariadic() {

		XCTAssertTrue(
			noneOf(
				Predicate<Int> { _ in false },
				Predicate<Int> { _ in false },
				Predicate<Int> { _ in false }
			).contains(0), "Should be true"
		)

		XCTAssertFalse(
			noneOf(
				Predicate<Int> { _ in false },
				Predicate<Int> { _ in true },
				Predicate<Int> { _ in false }
			).contains(0), "Should be false"
		)
	}
}

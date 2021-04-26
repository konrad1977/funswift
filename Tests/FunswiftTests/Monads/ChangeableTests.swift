import XCTest
@testable import Funswift

final class ChangeableTests: XCTestCase {

	struct Person: Equatable { var name: String, lastname: String }

	func testMap() {

		let result = Changeable(10)
			.map(String.init)

		XCTAssertEqual("10", result.value)
		XCTAssertEqual(result.hasChanges, false, "Should be changed because we change the internal type to string")

		let identityResult = Changeable(10)
					.map(identity)

		XCTAssertEqual(10, identityResult.value)
		XCTAssertEqual(result.hasChanges, false, "Should be changed because we change the internal type to string")
	}

	func testWrite() {
		let person = Person(name: "Jane", lastname: "Doe")
		var result = Changeable<Person>(person)

		result = result.write("Joe", at: \.name)
		XCTAssertTrue(result.hasChanges, "Should contain changes")

		result = result.write("Doe", at: \.lastname)
		XCTAssertFalse(result.hasChanges, "Should contain changes")
	}

	func testWriteFlatMap() {
		let person = Person(name: "Jane", lastname: "Doe")
		let result = Changeable<Person>(person)
			.flatMap(write("Jane", at: \.name))
			.flatMap(write("Doe", at: \.lastname))

		XCTAssertFalse(result.hasChanges, "Should contain changes")
	}

	func testWriteBind() {
		let person = Person(name: "Jane", lastname: "Doe")
		let result = Changeable<Person>(person)
			 >>- write("Jane", at: \.name)
			 >>- write("Doe", at: \.lastname)

		XCTAssertFalse(result.hasChanges, "Should contain changes")
	}
}

import XCTest
@testable import Funswift

final class ChangeableTests: XCTestCase {

	func testMapChangeable() {

		let result = Changeable(value: 10, hasChanges: false)
			.map(String.init)

		XCTAssertEqual("10", result.value)
		XCTAssertEqual(result.hasChanges, true, "Should be changed")
	}
}

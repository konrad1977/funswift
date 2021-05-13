import XCTest
@testable import Funswift

final class DictionaryTests: XCTestCase {

	func testSemigroup() {
		let result: [String: String] = ["Json": "Accept"] <> ["Bearer": "Token"]
		XCTAssertEqual(result["Json"], "Accept")
		XCTAssertEqual(result["Bearer"], "Token")
	}
}

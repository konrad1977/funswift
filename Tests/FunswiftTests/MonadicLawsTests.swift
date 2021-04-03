import XCTest
@testable import Funswift

final class MonadicLawsTests: XCTestCase {

	private func upperCased(_ value: String) -> IO<String> {
		IO { value.uppercased() }
	}

	private func reversed(_ value: String) -> IO<String> {
		IO { String(value.reversed()) }
	}

	// monad.flatMap { pure($0).map(f) } == monad.map(f)
	func testIOFirstMonadicLaw() {
		let monad = IO { "Hello world" }
		let first = monad.flatMap { pure($0).map { $0.uppercased() } }
		let second = monad.map { $0.uppercased() }
		XCTAssertTrue(first == second)
	}

	// monad.flatMap(f).flatMap(g) == monad.flatMap { f($0).flatMap(g) }
	func testIOSecondMonadicLaw() {
		let monad = IO { "Hello world" }
		let first = monad.flatMap(upperCased).flatMap(reversed)
		let second = monad.flatMap { self.upperCased($0).flatMap(self.reversed) }
		XCTAssertTrue(first == second)
	}
}

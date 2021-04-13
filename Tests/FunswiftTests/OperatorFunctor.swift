import XCTest
@testable import Funswift

final class OperatorFunctor: XCTestCase {

	func incr(_ value: Int) -> Int { value + 1 }
	func uppercased(_ value: String) -> String { value.uppercased() }

    func testArrayMap() {
        let result = [1,2,3] <&> incr
        XCTAssertEqual([2,3,4], result)
    }

    func testResultMap() {
        let result = Result.success(10) <&> incr
        try XCTAssertEqual(11, result.get())
    }

    func testIOMap() {
        let result = IO { "Hello world" } <&> uppercased
        XCTAssertEqual("HELLO WORLD", result.unsafeRun())
    }

	func testDefferedMap() {
		let deferred = Deferred { $0("Hello world") } <&> uppercased
		deferred.run { result in
			XCTAssertEqual("HELLO WORLD", result)
		}
	}

	func testReaderMap() {
		let reader = Reader<Void, String> { "Hello world" } <&> uppercased
		XCTAssertEqual("HELLO WORLD", reader.run(()))
	}

	func testChangeableMap() {
		let changeable = Changeable("Hello world") <&> uppercased
		XCTAssertEqual("HELLO WORLD", changeable.value)
		XCTAssertFalse(changeable.hasChanges)
	}
}

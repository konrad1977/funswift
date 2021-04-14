import XCTest
@testable import Funswift

final class OperatorFunctor: XCTestCase {

	func incr(_ value: Int) -> Int { value + 1 }
	func uppercased(_ value: String) -> String { value.uppercased() }
    func lowercased(_ value: String) -> String { value.lowercased() }

    func testArrayMap() {
        let result = [1,2,3] <&> incr
        XCTAssertEqual([2,3,4], result)
    }

    func testOptionalMap() {
        let str: String? = "Hello world" <&> uppercased
        XCTAssertEqual("HELLO WORLD", str)
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
		let reader = Reader<String, String> { "Hello \($0)" } <&> uppercased
		XCTAssertEqual("HELLO WORLD", reader.run("WORLD"))
	}

	func testChangeableMap() {
		let changeable = Changeable("Hello world") <&> uppercased
		XCTAssertEqual("HELLO WORLD", changeable.value)
		XCTAssertFalse(changeable.hasChanges)
	}

    func testStateMap() {
        let state = State<Bool, String> { state in
            (state, state ? "HELLO WORLD" : "Hello world")
        }

        XCTAssertEqual("HELLO WORLD", state.eval(state: true))
        XCTAssertEqual("Hello world", state.eval(state: false))

        // Will override and make it upper cased
        XCTAssertEqual("HELLO WORLD", (state <&> uppercased).eval(state: false))
        XCTAssertEqual("hello world", (state <&> lowercased).eval(state: true))
    }
}

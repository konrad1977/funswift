import XCTest
@testable import Funswift

final class OperatorFunctor: XCTestCase {

    func testArrayMap() {
        let result = [1,2,3] <&> { $0 + 1 }
        XCTAssertEqual([2,3,4], result)
    }

    func testResultMap() {
        let result = Result.success(10) <&> { $0 + 1 }
        try XCTAssertEqual(11, result.get())
    }

    func testIOMap() {
        let result = IO { "Hello world" } <&> { $0.uppercased() }
        XCTAssertEqual("HELLO WORLD", result.unsafeRun())
    }
}

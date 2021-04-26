import XCTest
@testable import Funswift

final class OptionalsExtensionTests: XCTestCase {

    func testOptionalZip2() {
        XCTAssertEqual(zip(10, 0)?.0, 10)
        XCTAssertEqual(zip(10, 10.5)?.1, 10.5)
    }

    func testOptionalZip2Nil() {
        let nilValue: Int? = nil
        XCTAssertNil(zip(nilValue, 10))
        XCTAssertNil(zip(10, nilValue))
    }

    func testOptionalZip3Nil() {
        let nilValue: Int? = nil
        let result = zip(nilValue, 10, 10)
        XCTAssertNil(result)
    }

    func testOptionalZip3Clean() {
        let result = zip(10.2, 10, "Hello world")
        XCTAssertNotNil(result)

        XCTAssertEqual(result?.0, 10.2)
        XCTAssertEqual(result?.1, 10)
        XCTAssertEqual(result?.2, "Hello world")
    }

    func testOptionalZip4() {
        let result = zip(10.2, 10, "Hello world", "Run")
        XCTAssertNotNil(result)

        XCTAssertEqual(result?.0, 10.2)
        XCTAssertEqual(result?.1, 10)
        XCTAssertEqual(result?.2, "Hello world")
        XCTAssertEqual(result?.3, "Run")
    }

    func testOptionalZip5() {
        let result = zip(10.2, 10, "Hello world", "Run", 0.0001)
        XCTAssertNotNil(result)

        XCTAssertEqual(result?.0, 10.2)
        XCTAssertEqual(result?.1, 10)
        XCTAssertEqual(result?.2, "Hello world")
        XCTAssertEqual(result?.3, "Run")
        XCTAssertEqual(result?.4, 0.0001)
    }

    func testOptionalZip6() {

        let result = zip(
            10.2,
            10,
            "Hello world",
            "Run",
            0.0001,
            "1"
        )
        XCTAssertNotNil(result)

        XCTAssertEqual(result?.0, 10.2)
        XCTAssertEqual(result?.1, 10)
        XCTAssertEqual(result?.2, "Hello world")
        XCTAssertEqual(result?.3, "Run")
        XCTAssertEqual(result?.4, 0.0001)
        XCTAssertEqual(result?.5, "1")
    }

    func testOptionalZip7() {

        let result = zip(
            10.2,
            10,
            "Hello world",
            "Run",
            0.0001,
            "1",
            8
        )
        XCTAssertNotNil(result)

        XCTAssertEqual(result?.0, 10.2)
        XCTAssertEqual(result?.1, 10)
        XCTAssertEqual(result?.2, "Hello world")
        XCTAssertEqual(result?.3, "Run")
        XCTAssertEqual(result?.4, 0.0001)
        XCTAssertEqual(result?.5, "1")
        XCTAssertEqual(result?.6, 8)
    }

    func testOptionalZip8() {

        let result = zip(
            10.2,
            10,
            "Hello world",
            "Run",
            0.0001,
            "1",
            8,
            ""
        )
        XCTAssertNotNil(result)

        XCTAssertEqual(result?.0, 10.2)
        XCTAssertEqual(result?.1, 10)
        XCTAssertEqual(result?.2, "Hello world")
        XCTAssertEqual(result?.3, "Run")
        XCTAssertEqual(result?.4, 0.0001)
        XCTAssertEqual(result?.5, "1")
        XCTAssertEqual(result?.6, 8)
        XCTAssertEqual(result?.7, "")
    }

    func testOptionalZip9() {

        let result = zip(
            10.2,
            10,
            "Hello world",
            "Run",
            0.0001,
            "1",
            8,
            "",
            ""
        )
        XCTAssertNotNil(result)

        XCTAssertEqual(result?.0, 10.2)
        XCTAssertEqual(result?.1, 10)
        XCTAssertEqual(result?.2, "Hello world")
        XCTAssertEqual(result?.3, "Run")
        XCTAssertEqual(result?.4, 0.0001)
        XCTAssertEqual(result?.5, "1")
        XCTAssertEqual(result?.6, 8)
        XCTAssertEqual(result?.7, "")
        XCTAssertEqual(result?.8, "")
    }

    func testOptionalZip10() {

        let result = zip(
            pure(10.2),
            pure(10),
            pure("Hello world"),
            pure("Run"),
            pure(0.0001),
            pure("1"),
            pure(8),
            pure(""),
            pure(""),
            .some(10)
        )
        XCTAssertNotNil(result)

        XCTAssertEqual(result?.0, 10.2)
        XCTAssertEqual(result?.1, 10)
        XCTAssertEqual(result?.2, "Hello world")
        XCTAssertEqual(result?.3, "Run")
        XCTAssertEqual(result?.4, 0.0001)
        XCTAssertEqual(result?.5, "1")
        XCTAssertEqual(result?.6, 8)
        XCTAssertEqual(result?.7, "")
        XCTAssertEqual(result?.8, "")
        XCTAssertEqual(result?.9, 10)
    }
}

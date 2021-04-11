import XCTest
@testable import Funswift

final class IOTests: XCTestCase {

    private func delayedInt(completion: @escaping (Int) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            completion(101)
        }
    }

	func testMap() {

		let result = IO<Int> { 10 }
			.map(String.init)
			.unsafeRun()

		XCTAssertEqual("10", result)
	}

	func testFlatMap() {

		let multiplyWithHundred: (Int) -> IO<Int> = { number in IO { number * 100 } }

		let result = IO<Int> { 10 }
			.flatMap(multiplyWithHundred)
			.flatMap(multiplyWithHundred)
			.flatMap(multiplyWithHundred)
			.unsafeRun()

		XCTAssertEqual(10000000, result)
	}

	func testBindOperator() {

		let multiplyWithHundred: (Int) -> IO<Int> = { number in IO { number * 100 } }

		let result = IO<Int> { 10 }
			>>- multiplyWithHundred
			>>- multiplyWithHundred
			>>- multiplyWithHundred

		XCTAssertEqual(10000000, result.unsafeRun())
	}

	func testMapOperator() {
		let result = IO<Int> { 10 } <&> String.init
		XCTAssertEqual("10", result.unsafeRun())

	}

	func testPure() {
		let result = pure(10).unsafeRun()
		XCTAssertEqual(10, result)

		let resultB = IO<Double>.pure(100.2).unsafeRun()
		XCTAssertEqual(100.2, resultB)
	}

	func testZip2() {
		let result = zip(
			pure(10),
			pure(100.0)
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
	}

	func testZip3() {
		let result = zip(
			pure(10),
			pure(100.0),
			IO { "Hello world" }
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
		XCTAssertEqual("Hello world", result.2)
	}

	func testZip4() {
		let result = zip(
			pure(10),
			pure(100.0),
			IO { "Hello world" },
			IO { 10.2 }
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
		XCTAssertEqual("Hello world", result.2)
		XCTAssertEqual(10.2, result.3)
	}

	func testZip5() {

		let result = zip(
			pure(10),
			pure(100.0),
			IO { 20 },
			IO { "Hello world" },
			IO { "Boom" }
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
		XCTAssertEqual(20, result.2)
		XCTAssertEqual("Hello world", result.3)
		XCTAssertEqual("Boom", result.4)
	}

	func testZip6() {

		let result = zip(
			pure(10),
			pure(100.0),
			IO { 20 },
			IO { "Hello world" },
			IO { "Boom" },
			IO { 10.2 }
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
		XCTAssertEqual(20, result.2)
		XCTAssertEqual("Hello world", result.3)
		XCTAssertEqual("Boom", result.4)
		XCTAssertEqual(10.2, result.5)
	}

	func testZip7() {

		let result = zip(
			pure(10),
			pure(100.0),
			IO { 20 },
			IO { "Hello world" },
			IO { "Boom" },
			IO { 10.2 },
			IO<URL?> { URL(string: "www.google.se") }
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
		XCTAssertEqual(20, result.2)
		XCTAssertEqual("Hello world", result.3)
		XCTAssertEqual("Boom", result.4)
		XCTAssertEqual(10.2, result.5)
		XCTAssertEqual(URL(string: "www.google.se"), result.6)
	}

	func testZip8() {

		struct Person: Equatable { let name: String }

		let result = zip(
			pure(10),
			pure(100.0),
			IO { 20 },
			IO { "Hello world" },
			IO { "Boom" },
			IO { 10.2 },
			IO<URL?> { URL(string: "www.google.se") },
			IO<Person> { Person(name: "Jane") }
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
		XCTAssertEqual(20, result.2)
		XCTAssertEqual("Hello world", result.3)
		XCTAssertEqual("Boom", result.4)
		XCTAssertEqual(10.2, result.5)
		XCTAssertEqual(Person(name: "Jane"), result.7)
	}

	func testZip9() {

		struct Person: Equatable { let name: String }

		let result = zip(
			pure(10),
			pure(100.0),
			IO { 20 },
			IO { "Hello world" },
			IO { "Boom" },
			IO { 10.2 },
			IO<URL?> { URL(string: "www.google.se") },
			IO<Person> { Person(name: "Jane") },
			IO<CGRect> { .init(x: 1, y: 2, width: 200, height: 100) }
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
		XCTAssertEqual(20, result.2)
		XCTAssertEqual("Hello world", result.3)
		XCTAssertEqual("Boom", result.4)
		XCTAssertEqual(10.2, result.5)
		XCTAssertEqual(Person(name: "Jane"), result.7)
		XCTAssertEqual(CGRect(x: 1, y: 2, width: 200, height: 100), result.8)
	}

	func testZip10() {

		struct Person: Equatable { let name: String }

		let result = zip(
			pure(10),
			pure(100.0),
			IO { 20 },
			IO { "Hello world" },
			IO { "Boom" },
			IO { 10.2 },
			IO<URL?> { URL(string: "www.google.se") },
			IO<Person> { Person(name: "Jane") },
			IO<CGRect> { .init(x: 1, y: 2, width: 200, height: 100) },
			IO<String.SubSequence> { .init("Hello") }
		).unsafeRun()

		XCTAssertEqual(10, result.0)
		XCTAssertEqual(100.0, result.1)
		XCTAssertEqual(20, result.2)
		XCTAssertEqual("Hello world", result.3)
		XCTAssertEqual("Boom", result.4)
		XCTAssertEqual(10.2, result.5)
		XCTAssertEqual(Person(name: "Jane"), result.7)
		XCTAssertEqual(CGRect(x: 1, y: 2, width: 200, height: 100), result.8)
		XCTAssertEqual(String.SubSequence("Hello"), result.9)
	}

    func testInitFromDeferred() {
        let delayedDeferred = Deferred.delayed(by: 2) { 10 }
        let result = IO(deferred: delayedDeferred).unsafeRun()
        XCTAssertEqual(10, result)
    }

    func testIODeferredZip() {
        let delayedDeferred = Deferred.delayed(by: 2) { 10 }
        let result = zip(
            IO(deferred: delayedDeferred),
            IO(deferred: delayedDeferred)
        ).unsafeRun()
        XCTAssertEqual(10, result.0)
        XCTAssertEqual(10, result.1)
    }

    func testInitFromCallback() {
        let result = IO(delayedInt(completion:)).unsafeRun()
        XCTAssertEqual(101, result)
    }
}

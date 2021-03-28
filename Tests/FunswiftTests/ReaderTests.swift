import XCTest
@testable import Funswift

final class ReaderTests: XCTestCase {

	struct User {
		let id: Int
		var name: String
		var email: String
		var age: Int
	}

	struct Repository {
		let users: [User]
		func getUser(id: Int) -> User? { users.first(where: { $0.id == id }) }
	}

	let repository = Repository(
		users: [
			.init(id: 1, name: "Jane", email: "jane@jane.com", age: 34),
			.init(id: 2, name: "Joe", email: "joe@joe.com", age: 29)
		]
	)

	private func getUser(id: Int) -> Reader<Repository, User?> {
		Reader { $0.getUser(id: id) }
	}

	private func getEmail(id: Int) -> Reader<Repository, String?> {
		getUser(id: id).map { $0?.email }
	}

	func testSimpleRun() throws {
		let user = try XCTUnwrap(
			getUser(id: 1)
				.run(repository)
		)
		XCTAssertEqual(user.name, "Jane")
		XCTAssertEqual(user.email, "jane@jane.com")
		XCTAssertEqual(user.age, 34)
	}

	func testMapIdentity() throws {

		let user = try XCTUnwrap(
			getUser(id: 1)
				.map(identity)
				.run(repository)
		)
		XCTAssertEqual(user.age, 34)
		XCTAssertEqual(user.name, "Jane")
		XCTAssertEqual(user.email, "jane@jane.com")
	}

	func testMap() {
		let reader = Reader<Int, Int> { $0 }
			.map(String.init)
			.run(100)
		XCTAssertEqual(reader, "100")
	}

	func testFlatmap() throws {

		let increamentUserAge: (User?) -> Reader<Repository, User?> = { currentUser in
			return Reader<Repository, User?> {
				guard let id = currentUser?.id
				else { return nil }
				var user = $0.getUser(id: id)
				user?.age += 1
				return user
			}
		}

		let user = try XCTUnwrap(
			getUser(id: 1)
				.map(identity)
				.run(repository)
		)
		XCTAssertEqual(user.age, 34)

		let olderUser = try XCTUnwrap(
			getUser(id: 1)
			.flatMap(increamentUserAge)
			.run(repository)
		)
		XCTAssertEqual(olderUser.age, user.age + 1)
		XCTAssertEqual(olderUser.id, user.id)
	}

	func testReturnValue() {
		let reader = Reader<Int, Int> { $0 }
			.run(100)
		XCTAssertEqual(reader, 100)
	}
}

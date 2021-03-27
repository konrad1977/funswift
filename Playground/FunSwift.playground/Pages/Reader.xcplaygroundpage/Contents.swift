//: [Previous](@previous)

import Foundation
import Funswift

struct User {
	let name: String
	let email: String
}

struct Repository {
	let users: [User]
	func getUser(id: Int) -> User { users[id] }
}

func getUser(id: Int) -> Reader<Repository, User> {
	Reader { $0.getUser(id: id) }
}

func getEmail(id: Int) -> Reader<Repository, String> {
	getUser(id: id).map { $0.email }
}

let testRepo =
	Repository(
		users: [
			.init(name: "Jane-test", email: "jane@jane-test.com"),
			.init(name: "Joe-test", email: "joe@joe-test.com")
		]
	)

let liveRepo =
	Repository(
		users: [
			.init(name: "Jane", email: "jane@jane.com"),
			.init(name: "Joe", email: "joe@joe.com")
		]
	)

zip(
	getUser(id: 0),
	getUser(id: 1)
).run(testRepo)

getUser(id: 0).run(liveRepo)

//: [Next](@next)

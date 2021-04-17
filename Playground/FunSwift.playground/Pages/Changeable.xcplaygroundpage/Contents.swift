//: [Previous](@previous)

import Foundation
import Funswift

class Person {
	var firstName: String
	var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

let person = Person(firstName: "Jane", lastName: "Doe")

let changeablePerson =
	Changeable(value: person, hasChanges: false)
	>>- write("Jane", at: \.firstName)
	>>- write("Doe Jr", at: \.lastName)

changeablePerson.hasChanges
	? print("Was changed")
	: print("Nothing was changed")

//: [Next](@next)

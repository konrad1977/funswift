A tiny package full of functional tools that you can use in your apps



!["Logo"](https://github.com/konrad1977/funswift/blob/main/Images/logo.png)



Funswift includes several playground pages so you can see how a specific functionality can be used. Some of the types can be used in many different situations and we cannot cover them all. 

Our goal is to have tests and a high codecoverage. If you find bugs - please report it in the issues or even better do a Pull Request.



![](https://img.shields.io/github/license/konrad1977/funswift) ![](https://img.shields.io/github/languages/top/konrad1977/funswift)



## Installation

```swift
import PackageDescription

let package = Package(
  dependencies: [
    .package(url: "https://github.com/konrad1977/funswift", .branch("main")),
  ]
)
```



## Whats included

##### Playground

I've added Playground pages where you can poke around and try some of the feature set of funswift. 

##### Tests

My goal is to provide tests for all the [monad laws](https://wiki.haskell.org/Monad_laws) and [functor laws](https://wiki.haskell.org/Functor). Right now I am aiming for 100% Codecoverage.

### Monads

\- [IO](#IO)

\- [Deferred](#deferred)

\- `Reader`

\- `Writer`

\- `Changeable`

\- `State`

#### Non monads

\- `Predicate`

\- `Endo`

\- `Memoization`

#### Operators

\- `<*>`  Applicatives 

\- `>>-`  Bind 

\- `>=>`  Fish

\- `>>>`  Forward compose 

\- `<<<`  Backward Compose 

\- `|>`  Pipe

### Semigroup protocol

Allows sets/types to be concatinated by using the + operator. 

```swift
extension String: Semigroup {}
"Hello " + "world" // Hello world

extension Array: Semigroup {}
[object] + [anotherObject] // [object, anotherObject]
```

This allows us to use Semigroup protocol instead where we want to concatinate objects, we added generalization we no longer need to work with concrete types. Semigroup always returns the same type. So if we do A + A = A

### Monoid protocol

Monoid inherits from Semigroup but adds the posibility to be empty/return an empty object. For instance an empty string  "" or an empty array [].

### Why focus on monads?

Funswift is not all about monads but its my main focus. They solve some specific problems and make life easier as a developer no matter if you prefeer imperative or functional style. And swift is already full of monads, like `string`, `SubString`, `Array` (sequenses), `Optional` and `Result`.

#### Some common features of all the monads in the funswift.

All monads supports atleast three functions: `pure`, `flatMap` and `map`. Some of them have support for `zip` and convience methods for instantiate itself from another monadic type. `IO` can for instance be created from a `Deferred` and `Deferred` can be created from an `IO`.

`pure` helps you lift a parametric value up to the world of the monadic values. Its just a simple way of creating a monad with a wrapped value. Its called `Some`, and `Just` in some other languages.

All monads produces a value, and they are all Covariant on their outputs. Some like the Reader which both producers and consumes value are Covariant on the output and Contravariant on the input. 

### IO

In pure functional languages like Haskell its impossible to have an effect without using monads. An effect can be reading from input, disk, network or anything else outside your control. An easy way of dealing with effects is to wrap a value inside an `IO`-monad. `IO` allows manipulating effects, transform (`map`), and chain (bind, `flatmap`, `>>-`) them. IO is also lazy which is also another important aspect of functional programming. To run an IO-effect you need to call `unsafeRun()` . 

```swift
let lazyHelloWorld = IO<String> { "hello world" }
lazyHelloWorld.unsafeRun() // "hello world"
```

### Deferred

Sometimes you don't know when the code is done executing and you dont want to block the main thread. Then Deferred is here to the rescue. Deferred is often called *Future/Promise* in some languages. Its a functional pattern of handling async code. To get the value out of a Deferred you need to run it. Its lazy as IO but the main different is that it wont block the thread while you are waiting it to complete. Its not unusual to see people trying to synchronize async code with DispatchGroups which very often leads to unclear and messy code. It also has the downside that it cannot be tranformed or chained easily. Deferred also ads the ability to chain (`flatMap`, `>>-`), and transform (`map`) which makes the code cleaner, easier to understand and easier to reuse. 

#### Curry

In functional languages its very common to have functions that takes one value and returns a value. Functions that takes several values are often curried so they can be partially applied. Funswift has some overloads of curry to help out with that.

***Example of currying.*** 

```swift
func takesTwo(first: Int, second: Int) -> Int // (Int, Int) -> Int
curry(takesTwo) // (Int) -> (Int) -> Int
```

### Swift.Result extensions

Apple added Result to Swift version 5.0. But it felt like we had this for years. Funswift adds even more functionality to it by adding `zip`, `concat`, `onSuccess` and `onFailure`.

```swift
func validate(username: String) -> Result<String, Error> { ... }
func validate(password: String) -> Result<String, Error> { ... }

zip(
  validate(username: "Jane"),
  validate(password: "Doe")
)
.map(Person.init)
.onSuccess(showSuccess)
.onFailure(showValidationError)
```

### Credits

- If you like the Functional Programming style and don't really know where to start. I can highly recommend the video series on Functional Programming in Swift by [Pointfree.co](https://www.pointfree.co). They inspired me to learn more about the subject and alot of their style and naming conventions can be found in funswift.

- [Category Theory for programmers](https://github.com/hmemcpy/milewski-ctfp-pdf)

  Bartosz excellent book which is available for free. Its been a huge inspiration, and some times mind bending to read. 

- Objc.io [Functional Swift](https://www.objc.io/books/functional-swift/)

I also recommend just searching on the internet to get more information about a specific monad to deeper your understanding of it. [Haskell Wiki](https://wiki.haskell.org/All_About_Monads) is a great source of information.


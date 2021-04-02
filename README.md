A tiny package full of functional tools that you can use in your apps

!["Logo"](https://github.com/konrad1977/funswift/blob/main/Images/logo.png)

Funswift includes several playground pages so you can see how a specific functionality can be used. Some of the types can be used in many different situations and we cannot cover them all. 

Our goal is to have tests and a high codecoverage. If you find bugs - please report it in the issues or even better do a Pull Request.

![](https://img.shields.io/github/license/konrad1977/funswift) ![](https://img.shields.io/github/languages/top/konrad1977/funswift)


# Whats included

##### Monads
- `IO`
- `Deferred`
- `Reader`
- `Writer`
- `Changeable`
- `State`

#### Non monads
- `Predicate`
- `Endo`
- `Memoization`

#### Operators
- `<*>`	Applicatives 
- `>>-`	Bind 
- `>=>`	Fish
- `>>>`	Forward compose 
- `<<<`	Backward Compose 
- `|>`	Pipe

#### Protocols
- `Monoid`
- `Semigroup`

#### Extended swift types
- `Result`
- zip
- onSuccess	
- onFailure
- concat

### Why focus on monads?
Funswift is not all about monads but its our main focus. They solve some specific problems and make life easier as a developer no matter if you prefeer imperative or functional style. And swift is already full of monads, like `string`, `SubString`, `Array` (sequenses), `Optional`, `Result`.

##### IO Monad
In pure functional languages like Haskell its impossible to have effect without using monads. An effect can be reading from input, disk, network and its something you're not in fully control of. One of the easiest way is to wrap the effect inside a `IO`-monad. `IO` lets to safetly manipulate effects, transform (`map`), and chain (bind, `flatmap`, `>>-`) them. IO is completely lazy, its not until you call `unsafeRun()` it will execute (in sequence) and return a result.

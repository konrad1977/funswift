A tiny package full of functional tools that you can use in your apps

!["Logo"](https://github.com/konrad1977/funswift/blob/main/Images/logo.png)

Funswift includes several playground pages so you can see how a specific functionality can be used. Some of the types can be used in many different situations and we cannot cover them all. 
Our goal is to have tests and a high codecoverage. If you find bugs - please report it in the issues or even better do a Pull Request.

![](https://img.shields.io/github/license/konrad1977/funswift) ![](https://img.shields.io/github/languages/top/konrad1977/funswift)


# Whats included
==
##### Monads

\- `IO`

\- `Deferred`

\- `Reader`

\- `Writer`

\- `Changeable`

\- `State`



#### Non monads

\- `Predicate`

\- `Endo`

\- `Memoization`



#### Operators

\- `<*>`    Applicatives 

\- `>>-`    Bind 

\- `>=>`    Fish

\- `>>>`    Forward compose 

\- `<<<`    Backward Compose 

\- `|>`    Pipe



#### Protocols

\- `Monoid`

\- `Semigroup`



#### Extended swift types

\- `Result`

\- zip

\- onSuccess    

\- onFailure

\- concat



### Why focus on monads?

Funswift is not all about monads but its our main focus. They solve some specific problems and make life easier as a developer no matter if you prefeer imperative or functional style. And swift is already full of monads, like `string`, `SubString`, `Array` (sequenses), `Optional`, `Result`.

#### Some common features of all the monads in the funswift.

All monads supports atleast three functions: `pure`, `flatMap` and `map`. Some of them have support for `zip` and convience methods for instantiate itself from another monadic type. `IO` can for instance be created from a `Deferred` and `Deferred` can be created from an `IO`.

`pure` helps you lift a parametric value up to the world of the monadic values. Its just a simple way of creating a monad with a wrapped value. Its called `Some`, and `Just` in some other languages.

All monads produces a value, and they are all Covariant on their outputs. Some like the Reader which both producers and consumes value are Covariant on the output and Contravariant on the input. 


##### IO Monad
In pure functional languages like Haskell its impossible to have an effect without using monads. An effect can be reading from input, disk, network or anything else outside your control. An easy way of dealing with effects is to wrap a value inside an `IO`-monad. `IO` allows manipulating effects, transform (`map`), and chain (bind, `flatmap`, `>>-`) them. IO is also lazy which is also another important aspect of functional programming. To run an IO-effect you need to call `unsafeRun()` . 

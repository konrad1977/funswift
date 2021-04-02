import Foundation
import Funswift


struct Result {
    let first: Int
    let second: Int
    let third: Int
}

zip(
    Deferred<Int> { $0(10) },
    Deferred<Int> { $0(20) },
    Deferred<Int> { $0(30) }
)
.map(Result.init)
.run { value in
    print(value)
}





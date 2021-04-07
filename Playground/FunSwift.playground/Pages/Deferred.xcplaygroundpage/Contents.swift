import Foundation
import Funswift
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func delay<A>(by interval: TimeInterval, work: @escaping () -> A) -> A {

    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue(label: "delay.queue")
    var result: A?

    dispatchGroup.enter()
    queue.asyncAfter(deadline: .now() + interval) {
        result = work()
        dispatchGroup.leave()
    }
    dispatchGroup.wait()
    return result!
}


zip(
    Deferred(delay(by: 1, work: { 10 + 10 })),
    Deferred(delay(by: 2, work: { 10 * 10 })),
    Deferred { $0(0.2) }
).run { first, second, third in
    print("Result: first: \(first) second: \(second) third: \(third)")
}









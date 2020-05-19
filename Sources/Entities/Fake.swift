/// A `Fake` allows to swap testable entity implementation with stored one.
final class Fake<Value> {

    private let closure: ([Argument]) -> Value

    init(_ fakeClosure: @escaping ([Argument]) -> Value) {
        closure = fakeClosure
    }
}

extension Fake: Invokable {

    func invoke(arguments: [Any]) -> Value {
        let arguments = arguments
            .enumerated()
            .map { Argument(value: $0.element, position: .init($0.offset)) }
        return closure(arguments)
    }
}

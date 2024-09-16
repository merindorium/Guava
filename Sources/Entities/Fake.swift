/// A `Fake` allows to swap testable entity implementation with stored one.
final class Fake<Value>: Sendable {

    private let closure: Closure<Value>

    init(_ fakeClosure: @escaping ([Argument]) -> Value) {
        closure = .normal(fakeClosure)
    }

    init(_ fakeThrowingClosure: @escaping ([Argument]) throws -> Value) {
        closure = .throwing(fakeThrowingClosure)
    }
}

extension Fake: Invokable {

    func invoke(arguments: [Any]) -> Value {
        guard case .normal(let closure) = closure else {
            FailureReporter
                .handler
                .handleFatalError(
                    .testDoubleTypeMismatch(expected: "Normal", received: closure.description),
                    location: nil
                )
        }
        let arguments = arguments
            .enumerated()
            .map { Argument(value: $0.element, position: .init($0.offset)) }
        return closure(arguments)
    }
}

extension Fake: ThrowingInvokable {

    func throwingInvoke(arguments: [Any]) throws -> Value {
        guard case .throwing(let closure) = closure else {
            FailureReporter
                .handler
                .handleFatalError(
                    .testDoubleTypeMismatch(expected: "Throwing", received: closure.description),
                    location: nil
                )
        }
        let arguments = arguments
            .enumerated()
            .map { Argument(value: $0.element, position: .init($0.offset)) }
        return try closure(arguments)
    }
}

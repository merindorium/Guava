/// A `Fake` allows to swap testable entity implementation with stored one.
final class Fake<Value> {

    private let closure: Closure<Value>

    init(_ fakeClosure: @escaping ([Argument]) -> Value) {
        closure = .normal(fakeClosure)
    }

    init(_ fakeThrowingClosure: @escaping ([Argument]) throws -> Value) {
        closure = .throwing(fakeThrowingClosure)
    }

    @available(iOS 13, macOS 10.15, *)
    init(_ fakeAsyncClosure: @escaping ([Argument]) async -> Value) {
        closure = .async(fakeAsyncClosure)
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

@available(iOS 13, macOS 10.15, *)
extension Fake: AsyncInvokable {

    func asyncInvoke(arguments: [Any]) async -> Value {
        guard case .async(let closure) = closure else {
            FailureReporter
                .handler
                .handleFatalError(
                    .testDoubleTypeMismatch(expected: "Async", received: closure.description),
                    location: nil
                )
        }

        let arguments = arguments
            .enumerated()
            .map { Argument(value: $0.element, position: .init($0.offset)) }
        return await closure(arguments)
    }
}

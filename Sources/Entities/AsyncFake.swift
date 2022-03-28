/// An `AsyncFake` allows to swap testable entity implementation with stored one.
@available(iOS 13, macOS 10.15, *)
actor AsyncFake<Value> {

    private let closure: AsyncClosure<Value>

    init(_ fakeAsyncClosure: @escaping @Sendable ([Argument]) async -> Value) {
        closure = .normal(fakeAsyncClosure)
    }

    init(_ fakeThrowingAsyncClosure: @escaping @Sendable ([Argument]) async throws -> Value) {
        closure = .throwing(fakeThrowingAsyncClosure)
    }
}

@available(iOS 13, macOS 10.15, *)
extension AsyncFake: AsyncInvokable {

    @Sendable
    func asyncInvoke(arguments: [Any]) async -> Value {
        guard case .normal(let closure) = closure else {
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

@available(iOS 13, macOS 10.15, *)
extension AsyncFake: ThrowingAsyncInvokable {

    @Sendable
    func throwingAsyncInvoke(arguments: [Any]) async throws -> Value {
        guard case .throwing(let closure) = closure else {
            FailureReporter
                .handler
                .handleFatalError(
                    .testDoubleTypeMismatch(expected: "AsyncThrowing", received: closure.description),
                    location: nil
                )
        }

        let arguments = arguments
            .enumerated()
            .map { Argument(value: $0.element, position: .init($0.offset)) }
        return try await closure(arguments)
    }
}

/// A `AsyncTestDoubleFactory` is a factory that allows to swap testable entity with several kinds of throwing doubles.
@available(iOS 13, macOS 10.15, *)
public actor AsyncTestDoubleFactory<Value> {

    private var invokeClosure: (@Sendable ([Any]) async -> Value)?

    public init() {}
}

@available(iOS 13, macOS 10.15, *)
extension AsyncTestDoubleFactory: AsyncInvokable {

    public func asyncInvoke(arguments: [Any]) async -> Value {
        guard let closure = invokeClosure else {
            FailureReporter.handler.handleFatalError(.nilValue, location: nil)
        }

        return await closure(arguments)
    }
}

@available(iOS 13, macOS 10.15, *)
extension AsyncTestDoubleFactory {

    /// Creates `AsyncStub`.
    /// - Parameter value: Stub value.
    /// - Parameter delayInNanoseconds: amount of nanoseconds to wait before returning a result.
    public func stub(_ value: Value, delayInNanoseconds: UInt64 = .zero) {
        let stub = AsyncStub(stubbedValue: value, delayInNanoseconds: delayInNanoseconds)

        invokeClosure = stub.asyncInvoke(arguments:)
    }

    /// Returns `AsyncSpy`.
    /// - Parameter value: Stub value.
    /// - Parameter delayInNanoseconds: amount of nanoseconds to wait before returning a result.
    public func spy(_ value: Value, delayInNanoseconds: UInt64 = .zero) -> AsyncSpy<Value> {
        let spy = AsyncSpy(value: value, delayInNanoseconds: delayInNanoseconds)

        invokeClosure = spy.asyncInvoke(arguments:)

        return spy
    }

    /// Creates `AsyncFake`.
    /// - Parameter closure: Async closure that will swap actual implementation of entity.
    public func fake(_ closure: @escaping @Sendable ([Argument]) async -> Value) {
        let fake = AsyncFake(closure)
        invokeClosure = fake.asyncInvoke(arguments:)
    }
}

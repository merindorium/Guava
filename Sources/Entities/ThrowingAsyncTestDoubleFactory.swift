/// A `AsyncTestDoubleFactory` is a factory that allows to swap testable entity with several kinds of throwing doubles.
@available(iOS 13, macOS 10.15, *)
public final class ThrowingAsyncTestDoubleFactory<Value> {

    private var invokeClosure: (([Any]) async throws -> Value)?

    public init() {}
}

@available(iOS 13, macOS 10.15, *)
extension ThrowingAsyncTestDoubleFactory: ThrowingAsyncInvokable {

    public func throwingAsyncInvoke(arguments: [Any]) async throws -> Value {
        guard let closure = invokeClosure else {
            FailureReporter.handler.handleFatalError(.nilValue, location: nil)
        }

        return try await closure(arguments)
    }
}

@available(iOS 13, macOS 10.15, *)
extension ThrowingAsyncTestDoubleFactory {

    /// Creates `Stub`.
    /// - Parameter value: Stub value.
    /// - Parameter delayInNanoseconds: amount of nanoseconds to wait before returning a result.
    public func stub(_ value: Value, delayInNanoseconds: UInt64 = .zero) {
        let stub = Stub(stubbedValue: value, delayInNanoseconds: delayInNanoseconds)

        invokeClosure = stub.throwingAsyncInvoke(arguments:)
    }

    /// Creates `Stub`.
    /// - Parameter error: Stub error to throw.
    /// - Parameter delayInNanoseconds: amount of nanoseconds to wait before returning a result.
    public func stub(_ error: Error, delayInNanoseconds: UInt64 = .zero) {
        let stub = Stub<Value>(error: error, delayInNanoseconds: delayInNanoseconds)

        invokeClosure = stub.throwingAsyncInvoke(arguments:)
    }

    /// Returns `Spy`.
    /// - Parameter value: Stub value.
    /// - Parameter delayInNanoseconds: amount of nanoseconds to wait before returning a result.
    public func spy(_ value: Value, delayInNanoseconds: UInt64 = .zero) -> Spy<Value> {
        let spy = Spy(value: value, delayInNanoseconds: delayInNanoseconds)

        invokeClosure = spy.throwingAsyncInvoke(arguments:)

        return spy
    }

    /// Returns `Spy`.
    /// - Parameter error: Stub error to throw.
    /// - Parameter delayInNanoseconds: amount of nanoseconds to wait before returning a result.
    public func spy(_ error: Error, delayInNanoseconds: UInt64 = .zero) -> Spy<Value> {
        let spy = Spy<Value>(error: error, delayInNanoseconds: delayInNanoseconds)

        invokeClosure = spy.throwingAsyncInvoke(arguments:)

        return spy
    }

    /// Creates `Fake`.
    /// - Parameter closure: Throwing async closure that will swap actual implementation of entity.
    public func fake(_ closure: @escaping ([Argument]) async throws -> Value) {
        let fake = Fake(closure)
        invokeClosure = fake.throwingAsyncInvoke(arguments:)
    }
}

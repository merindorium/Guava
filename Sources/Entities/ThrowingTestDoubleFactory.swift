import Foundation

/// A `ThrowingTestDoubleFactory` is a factory that allows to swap testable entity with several kinds of throwing doubles.
public final class ThrowingTestDoubleFactory<Value>: @unchecked Sendable {

    private let lock = NSLock()
    private var invokeClosure: (([Any]) throws -> Value)?

    public init() {}
}

extension ThrowingTestDoubleFactory: ThrowingInvokable {

    public func throwingInvoke(arguments: [Any]) throws -> Value {
        guard let closure = lock.withLock({ invokeClosure }) else {
            FailureReporter.handler.handleFatalError(.nilValue, location: nil)
        }

        return try closure(arguments)
    }
}

extension ThrowingTestDoubleFactory {

    /// Creates `Stub`.
    /// - Parameter value: Stub value.
    public func stub(_ value: Value) {
        let stub = Stub(stubbedValue: value)

        lock.withLock { invokeClosure = stub.throwingInvoke(arguments:) }
    }

    /// Creates `Stub`.
    /// - Parameter error: Stub error to throw.
    public func stub(_ error: Error) {
        let stub = Stub<Value>(error: error)

        lock.withLock { invokeClosure = stub.throwingInvoke(arguments:) }
    }

    /// Returns `Spy`.
    /// - Parameter value: Stub value.
    public func spy(_ value: Value) -> Spy<Value> {
        let spy = Spy(value: value)

        lock.withLock { invokeClosure = spy.throwingInvoke(arguments:) }

        return spy
    }

    /// Returns `Spy`.
    /// - Parameter error: Stub error to throw.
    public func spy(_ error: Error) -> Spy<Value> {
        let spy = Spy<Value>(error: error)

        lock.withLock { invokeClosure = spy.throwingInvoke(arguments:) }

        return spy
    }

    /// Creates `Fake`.
    /// - Parameter closure: Throwing closure that will swap actual implementation of entity.
    public func fake(_ closure: @escaping ([Argument]) throws -> Value) {
        let fake = Fake(closure)
        lock.withLock { invokeClosure = fake.throwingInvoke(arguments:) }
    }
}

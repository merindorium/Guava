import Foundation

/// A `TestDoubleFactory` is a factory that allows to swap testable entity with several kinds of doubles.
public final class TestDoubleFactory<Value>: @unchecked Sendable {

    private let lock = NSLock()

    private var invokeClosure: (([Any]) -> Value)?

    public init() {}
}

extension TestDoubleFactory: Invokable {

    public func invoke(arguments: [Any]) -> Value {
        guard let closure = lock.withLock({ invokeClosure }) else {
            FailureReporter.handler.handleFatalError(.nilValue, location: nil)
        }

        return closure(arguments)
    }
}

extension TestDoubleFactory {

    /// Creates `Stub`.
    /// - Parameter value: Stub value.
    public func stub(_ value: Value) {
        let stub = Stub(stubbedValue: value)

        lock.withLock { invokeClosure = stub.invoke(arguments:) }
    }

    /// Returns `Spy`.
    /// - Parameter value: Stub value.
    public func spy(_ value: Value) -> Spy<Value> {
        let spy = Spy(value: value)

        lock.withLock { invokeClosure = spy.invoke(arguments:) }

        return spy
    }

    /// Creates `Fake`.
    /// - Parameter closure: Closure that will swap actual implementation of entity.
    public func fake(_ closure: @escaping ([Argument]) -> Value) {
        let fake = Fake(closure)
        lock.withLock { invokeClosure = fake.invoke(arguments:) }
    }
}

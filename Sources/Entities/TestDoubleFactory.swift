/// A `TestDoubleFactory` is a factory that allows to swap testable entity with several kinds of doubles.
public final class TestDoubleFactory<Value> {

    private var invokeClosure: (([Any]) -> Value)?

    public init() {}
}

extension TestDoubleFactory: Invokable {

    public func invoke(arguments: [Any]) -> Value {
        guard let closure = invokeClosure else {
            FailureReporter.handler.handleFatalError(.nilValue, location: nil)
        }

        return closure(arguments)
    }
}

extension TestDoubleFactory {

    /// Creates `Stub`.
    /// - Parameter value: Stub value.
    public func stub(_ value: Value) {
        let stub = Stub<Value, Never>(stubbedValue: value)

        invokeClosure = stub.invoke(arguments:)
    }

    /// Returns `Spy`.
    /// - Parameter value: Stub value.
    public func spy(_ value: Value) -> Spy<Value, Never> {
        let spy = Spy<Value, Never>(value: value)

        invokeClosure = spy.invoke(arguments:)

        return spy
    }

    /// Creates `Fake`.
    /// - Parameter closure: Closure that will swap actual implementation of entity.
    public func fake(_ closure: @escaping ([Argument]) -> Value) {
        let fake = Fake(closure)
        invokeClosure = fake.invoke(arguments:)
    }
}

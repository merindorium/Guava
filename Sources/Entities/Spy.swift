/// A `Spy` is a `Stub` that also records information about call.
public final class Spy<Value> {

    public private(set) var callArguments = [Argument]()
    public private(set) var callCount = 0

    private var stub: Stub<Value>

    public init(value: Value) {
        stub = Stub(stubbedValue: value)
    }
}

extension Spy: Invokable {

    public func invoke(arguments: [Any]) -> Value {
        callArguments = arguments.map { Argument(value: $0) }
        callCount += 1

        return stub.invoke(arguments: arguments)
    }
}

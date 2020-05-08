/// A `Spy` is a `Stub` that also records information about call.
public final class Spy<Value> {

    public private(set) var calls = [MethodCall]()

    private var stub: Stub<Value>

    public init(value: Value) {
        stub = Stub(stubbedValue: value)
    }
}

extension Spy: Invokable {

    public func invoke(arguments: [Any]) -> Value {
        let callArguments = arguments.map { Argument(value: $0) }
        calls.append(MethodCall(arguments: callArguments))

        return stub.invoke(arguments: arguments)
    }
}

public struct MethodCall {

    public let arguments: [Argument]
}

/// A `Spy` is a `Stub` that also records information about call.
public final class Spy<Value> {

    public private(set) var calls = [RecordedMethodCall]()

    private var stub: Stub<Value>

    public init(value: Value) {
        stub = Stub(stubbedValue: value)
    }
}

extension Spy: Invokable {

    public func invoke(arguments: [Any]) -> Value {
        calls.append(RecordedMethodCall(arguments: arguments))

        return stub.invoke(arguments: arguments)
    }
}

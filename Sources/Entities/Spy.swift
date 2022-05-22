/// A `Spy` is a `Stub` that also records information about call.
public final class Spy<Value, Failure: Error> {

    public private(set) var calls = [RecordedMethodCall]()

    private var stub: Stub<Value, Failure>

    public init(value: Value, delayInNanoseconds: UInt64 = .zero) {
        stub = Stub(stubbedValue: value, delayInNanoseconds: delayInNanoseconds)
    }

    public init(error: Failure, delayInNanoseconds: UInt64 = .zero) {
        stub = Stub(error: error, delayInNanoseconds: delayInNanoseconds)
    }
}

extension Spy: Invokable {

    public func invoke(arguments: [Any]) -> Value {
        calls.append(RecordedMethodCall(arguments: arguments))

        return stub.invoke(arguments: arguments)
    }
}

extension Spy: ThrowingInvokable {

    func throwingInvoke(arguments: [Any]) throws -> Value {
        calls.append(RecordedMethodCall(arguments: arguments))

        return try stub.throwingInvoke(arguments: arguments)
    }
}

@available(iOS 13, macOS 10.15, *)
extension Spy: AsyncInvokable {

    func asyncInvoke(arguments: [Any]) async -> Value {
        calls.append(RecordedMethodCall(arguments: arguments))

        return await stub.asyncInvoke(arguments: arguments)
    }
}

@available(iOS 13, macOS 10.15, *)
extension Spy: ThrowingAsyncInvokable {

    func throwingAsyncInvoke(arguments: [Any]) async throws -> Value {
        calls.append(RecordedMethodCall(arguments: arguments))

        return try await stub.throwingAsyncInvoke(arguments: arguments)
    }
}

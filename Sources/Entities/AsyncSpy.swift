/// An `AsyncSpy` is an `AsyncStub` that also records information about call.
@available(iOS 13, macOS 10.15, *)
public actor AsyncSpy<Value> {

    public private(set) var calls = [RecordedMethodCall]()

    private var stub: AsyncStub<Value>

    public init(value: Value, delayInNanoseconds: UInt64 = .zero) {
        stub = AsyncStub(stubbedValue: value, delayInNanoseconds: delayInNanoseconds)
    }

    public init(error: Error, delayInNanoseconds: UInt64 = .zero) {
        stub = AsyncStub(error: error, delayInNanoseconds: delayInNanoseconds)
    }
}

@available(iOS 13, macOS 10.15, *)
extension AsyncSpy: AsyncInvokable {

    @Sendable
    func asyncInvoke(arguments: [Any]) async -> Value {
        calls.append(RecordedMethodCall(arguments: arguments))

        return await stub.asyncInvoke(arguments: arguments)
    }
}

@available(iOS 13, macOS 10.15, *)
extension AsyncSpy: ThrowingAsyncInvokable {

    @Sendable
    func throwingAsyncInvoke(arguments: [Any]) async throws -> Value {
        calls.append(RecordedMethodCall(arguments: arguments))

        return try await stub.throwingAsyncInvoke(arguments: arguments)
    }
}

/// An `AsyncStub` provides hardcoded answers to calls made during the test.
@available(iOS 13, macOS 10.15, *)
actor AsyncStub<Value> {

    private let stubbedValue: Result<Value, Error>
    private let delayInNanoseconds: UInt64

    init(stubbedValue: Value, delayInNanoseconds: UInt64 = .zero) {
        self.stubbedValue = .success(stubbedValue)
        self.delayInNanoseconds = delayInNanoseconds
    }

    init(error: Error, delayInNanoseconds: UInt64 = .zero) {
        stubbedValue = .failure(error)
        self.delayInNanoseconds = delayInNanoseconds
    }
}

@available(iOS 13, macOS 10.15, *)
extension AsyncStub: AsyncInvokable {

    @Sendable
    func asyncInvoke(arguments: [Any]) async -> Value {
        guard case .success(let result) = stubbedValue else {
            FailureReporter
                .handler
                .handleFatalError(.testDoubleTypeMismatch(expected: "Async", received: "Throwing"), location: nil)
        }

        try? await Task.sleep(nanoseconds: delayInNanoseconds)
        return result
    }
}

@available(iOS 13, macOS 10.15, *)
extension AsyncStub: ThrowingAsyncInvokable {

    @Sendable
    func throwingAsyncInvoke(arguments: [Any]) async throws -> Value {
        try await Task.sleep(nanoseconds: delayInNanoseconds)

        switch stubbedValue {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

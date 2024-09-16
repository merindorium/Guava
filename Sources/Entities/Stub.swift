/// A `Stub` provides hardcoded answers to calls made during the test.
final class Stub<Value>: @unchecked Sendable {

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

extension Stub: Invokable {

    func invoke(arguments: [Any]) -> Value {
        guard case .success(let result) = stubbedValue else {
            FailureReporter
                .handler
                .handleFatalError(.testDoubleTypeMismatch(expected: "Normal", received: "Throwing"), location: nil)
        }

        return result
    }
}

extension Stub: ThrowingInvokable {

    func throwingInvoke(arguments: [Any]) throws -> Value {
        switch stubbedValue {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

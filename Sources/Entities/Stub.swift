/// A `Stub` provides hardcoded answers to calls made during the test.
final class Stub<Value> {

    private var stubbedValue: Result<Value, Error>

    init(stubbedValue: Value) {
        self.stubbedValue = .success(stubbedValue)
    }

    init(error: Error) {
        stubbedValue = .failure(error)
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

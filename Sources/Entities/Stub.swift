/// A `Stub` provides hardcoded answers to calls made during the test.
final class Stub<Value, Failure: Error> {

    private let stubbedValue: Result<Value, Failure>
    private let delayInNanoseconds: UInt64

    init(stubbedValue: Value, delayInNanoseconds: UInt64 = .zero) {
        self.stubbedValue = .success(stubbedValue)
        self.delayInNanoseconds = delayInNanoseconds
    }

    init(error: Failure, delayInNanoseconds: UInt64 = .zero) {
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

@available(iOS 13, macOS 10.15, *)
extension Stub: AsyncInvokable {

    func asyncInvoke(arguments: [Any]) async -> Value {
        guard case .success(let result) = stubbedValue else {
            FailureReporter
                .handler
                .handleFatalError(.testDoubleTypeMismatch(expected: "Async", received: "Throwing"), location: nil)
        }

        do {
            try await Task.sleep(nanoseconds: delayInNanoseconds)
        } catch {
            FailureReporter.handler.handleFatalError(.taskExplicitlyCanceled, location: nil)
        }
        return result
    }
}

@available(iOS 13, macOS 10.15, *)
extension Stub: ThrowingAsyncInvokable {

    func throwingAsyncInvoke(arguments: [Any]) async throws -> Value {
        do {
            try await Task.sleep(nanoseconds: delayInNanoseconds)
        } catch {
            FailureReporter.handler.handleFatalError(.taskExplicitlyCanceled, location: nil)
        }

        switch stubbedValue {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

import Combine

@available(iOS 13, macOS 10.15, *)
extension Stub: InvokablePublisher {
    typealias Output = Value
    
    func invoke(arguments: [Any]) -> AnyPublisher<Value, Failure> {
        switch stubbedValue {
        case .success(let value):
            return Result.Publisher(.success(value)).eraseToAnyPublisher()
        case .failure(let error):
            return Result.Publisher(.failure(error)).eraseToAnyPublisher()
        }
    }
}

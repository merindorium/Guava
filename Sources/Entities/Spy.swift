import Foundation

/// A `Spy` is a `Stub` that also records information about call.
public final class Spy<Value>: @unchecked Sendable {

    private let lock = NSLock()
    public private(set) var calls = [RecordedMethodCall]()

    private var stub: Stub<Value>

    public init(value: Value, delayInNanoseconds: UInt64 = .zero) {
        stub = Stub(stubbedValue: value, delayInNanoseconds: delayInNanoseconds)
    }

    public init(error: Error, delayInNanoseconds: UInt64 = .zero) {
        stub = Stub(error: error, delayInNanoseconds: delayInNanoseconds)
    }
}

extension Spy: Invokable {

    public func invoke(arguments: [Any]) -> Value {
        return lock.withLock {
            calls.append(RecordedMethodCall(arguments: arguments))

            return stub.invoke(arguments: arguments)
        }
    }
}

extension Spy: ThrowingInvokable {

    func throwingInvoke(arguments: [Any]) throws -> Value {
        return try lock.withLock {
            calls.append(RecordedMethodCall(arguments: arguments))

            return try stub.throwingInvoke(arguments: arguments)
        }
    }
}

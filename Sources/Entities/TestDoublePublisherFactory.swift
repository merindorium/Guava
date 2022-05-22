#if canImport(Combine)
import Combine

@available(iOS 13, macOS 10.15, *)
public final class TestDoublePublisherFactory<Output, Failure: Error> {

    private var invokePublisher: (([Any]) -> AnyPublisher<Output, Failure>)?

    public init() {}
}

@available(iOS 13, macOS 10.15, *)
extension TestDoublePublisherFactory: Invokable {

    public func invoke(arguments: [Any]) -> AnyPublisher<Output, Failure> {
        guard let publisher = invokePublisher else {
            FailureReporter.handler.handleFatalError(.nilValue, location: nil)
        }

        return publisher(arguments)
    }
}

@available(iOS 13, macOS 10.15, *)
extension TestDoublePublisherFactory {

    /// Creates `Stub`.
    /// - Parameter value: Stub value.
    public func stub(_ result: Result<Output, Failure>) {
        let stub = StubPublisher(result: result)

        invokePublisher = stub.invoke(arguments:)
    }

    /// Returns `Spy`.
    /// - Parameter value: Stub value.
    public func spy(_ result: Result<Output, Failure>) -> SpyPublisher<Output, Failure> {
        let spy = SpyPublisher(result)

        invokePublisher = spy.invoke(arguments:)

        return spy
    }

    /// Creates `Fake`.
    /// - Parameter closure: Closure that will swap actual implementation of entity.
    public func fake(_ publisherClosure: @escaping ([Argument]) -> AnyPublisher<Output, Failure>) {
        let fake = FakePublisher(publisherClosure)
        invokePublisher = fake.invoke(arguments:)
    }
}
#endif

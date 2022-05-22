#if canImport(Combine)
import Combine

@available(iOS 13, macOS 10.15, *)
public final class SpyPublisher<Output, Failure: Error> {
    public private(set) var calls = [RecordedMethodCall]()

    private var stub: StubPublisher<Output, Failure>

    public init(_ result: Result<Output, Failure>) {
        stub = StubPublisher(result: result)
    }
}

@available(iOS 13, macOS 10.15, *)
extension SpyPublisher: InvokablePublisher {

    func invoke(arguments: [Any]) -> AnyPublisher<Output, Failure> {
        calls.append(RecordedMethodCall(arguments: arguments))
        
        return stub.invoke(arguments: arguments)
    }
}
#endif

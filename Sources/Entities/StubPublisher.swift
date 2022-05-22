#if canImport(Combine)
import Combine

@available(iOS 13, macOS 10.15, *)
final class StubPublisher<Output, Failure: Error>  {
    private var result: Result<Output, Failure>
    
    init(result: Result<Output, Failure>) {
        self.result = result
    }
}

@available(iOS 13, macOS 10.15, *)
extension StubPublisher: InvokablePublisher {
    func invoke(arguments: [Any]) -> AnyPublisher<Output, Failure> {
        switch result {
        case let .success(value): return Result.Publisher(.success(value)).eraseToAnyPublisher()
        case let .failure(error): return Result.Publisher(.failure(error)).eraseToAnyPublisher()
        }
    }
}
#endif

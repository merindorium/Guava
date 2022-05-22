#if canImport(Combine)
import Combine

@available(iOS 13, macOS 10.15, *)
final class FakePublisher<Output, Failure: Error> {

    private let publisher: ([Argument]) -> AnyPublisher<Output, Failure>

    init(_ publisher: @escaping ([Argument]) -> AnyPublisher<Output, Failure>) {
        self.publisher = publisher
    }
}

@available(iOS 13, macOS 10.15, *)
extension FakePublisher: InvokablePublisher {

    func invoke(arguments: [Any]) -> AnyPublisher<Output, Failure> {
        let arguments = arguments
            .enumerated()
            .map { Argument(value: $0.element, position: .init($0.offset)) }
        return publisher(arguments)
    }
}
#endif

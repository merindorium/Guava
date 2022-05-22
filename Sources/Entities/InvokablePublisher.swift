#if canImport(Combine)
import Combine

/// Describes an entity which could be called with specific amount of arguments.

@available(iOS 13, macOS 10.15, *)
protocol InvokablePublisher {

    associatedtype Output
    associatedtype Failure: Error

    /// Mimics actual method.
    /// - Parameter arguments: Array of passed arguments.
    func invoke(arguments: [Any]) -> AnyPublisher<Output, Failure>
}
#endif

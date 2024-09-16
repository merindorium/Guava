/// Describes an entity which could throw and could be called asyncrounosly with specific amount of arguments.
@available(iOS 13, macOS 10.15, *)
protocol ThrowingAsyncInvokable: Sendable {

    associatedtype Output

    /// Mimics actual method.
    /// - Parameter arguments: Array of passed
    @Sendable
    func throwingAsyncInvoke(arguments: [Any]) async throws -> Output
}

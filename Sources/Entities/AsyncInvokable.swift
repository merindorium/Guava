/// Describes an entity which could be called asyncrounosly with specific amount of arguments.
@available(iOS 13, macOS 10.15, *)
protocol AsyncInvokable {

    associatedtype Output

        /// Mimics actual method.
        /// - Parameter arguments: Array of passed arguments.
    func asyncInvoke(arguments: [Any]) async -> Output
}

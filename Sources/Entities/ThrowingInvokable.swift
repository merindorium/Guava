/// Describes an entity which could be called and throw with specific amount of arguments.
protocol ThrowingInvokable {

    associatedtype Output

    /// Mimics actual method.
    /// - Parameter arguments: Array of passed arguments.
    func throwingInvoke(arguments: [Any]) throws -> Output
}

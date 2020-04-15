/// Describes an entity which could be called with specific amount of arguments.
protocol Invokable {

    associatedtype Output

    /// Mimics actual method.
    /// - Parameter arguments: Array of passed arguments.
    func invoke(arguments: [Any]) -> Output
}

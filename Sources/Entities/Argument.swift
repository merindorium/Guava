public struct Argument {

    /// Position of argument in method.
    public enum Position: String {

        case first
        case second
        case third
        case fourth
        case fifth
        case sixth
        case seventh
        case eighth
        case ninth

        /// Textual representation of argument position.
        public var name: String {
            return "\(self.rawValue) argument"
        }
    }

    /// Textual representation of stored value type.
    private var storedType: String {
        return "\(Mirror.init(reflecting: value).subjectType)"
    }

    private let value: Any

    init(value: Any) {
        self.value = value
    }

    /// Asserts that expected value is equal to stored one.
    /// - Parameters:
    ///   - expectedValue: Expected value of type `T`, where `T` is `Equatable`.
    ///   - position: Position of argument in method.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    @discardableResult
    func assertEqual<T>(_ expectedValue: T,
                        position: Position,
                        file: StaticString = #file,
                        line: UInt = #line) -> Bool where T: Equatable {
        guard let castedValue = asSafe(T.self) else {
                FailureReporter.handler.handleFailure(.typeMismatch(expectedType: "\(T.self)",
                                                                    receivedType: storedType,
                                                                    argument: position.name),
                                                      location: ReportLocation(file: file, line: line))
                return false
        }

        if castedValue != expectedValue {
            FailureReporter.handler.handleFailure(.valueMismatch(expectedValue: "\(expectedValue)",
                                                                receivedValue: "\(castedValue)",
                                                                argument: position.name),
                                                  location: ReportLocation(file: file, line: line))
            return false
        }

        return true
    }

    /// Casts stored value to expected `T` type.
    /// - Parameters:
    ///   - expectedType: Type used for casting.
    ///   - argumentPosition: Position of argument in method.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    func castStrictly<T>(to type: T.Type,
                         argumentPosition: Position,
                         file: StaticString = #file,
                         line: UInt = #line) -> T {
        guard let castedValue = asSafe(T.self) else {
            FailureReporter.handler.handleFatalError(.typeMismatch(expectedType: "\(T.self)",
                                                                  receivedType: storedType,
                                                                  argument: argumentPosition.name),
                                                    location: ReportLocation(file: file, line: line))
        }

        return castedValue
    }

    /// Tries to cast stored value to expected `T` type and returns result as `Optional<T>`.
    /// - Parameter expectedType: Type used for casting.
    /// - Returns: Optional result of type casting.
    public func asSafe<T>(_ expectedType: T.Type) -> T? {
        return value as? T
    }
}

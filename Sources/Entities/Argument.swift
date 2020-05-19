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
        case unknown

        /// Textual representation of argument position.
        public var name: String {
            return "\(self.rawValue) argument"
        }
    }

    /// Textual representation of stored value type.
    public var storedType: String {
        return "\(Mirror.init(reflecting: value).subjectType)"
    }

    /// Argument value.
    public let value: Any

    /// Argument position in method.
    public let position: Position

    init(value: Any, position: Position) {
        self.value = value
        self.position = position
    }

    /// Casts stored value to expected `T` type.
    /// - Parameters:
    ///   - expectedType: Type used for casting.
    ///   - argumentPosition: Position of argument in method.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    func castStrictly<T>(to type: T.Type,
                         file: StaticString = #file,
                         line: UInt = #line) -> T {
        guard let castedValue = asSafe(T.self) else {
            FailureReporter.handler.handleFatalError(.typeMismatch(expectedType: "\(T.self)",
                                                                   receivedType: storedType,
                                                                   argument: position.name),
                                                     location: ReportLocation(file: file, line: line))
        }

        return castedValue
    }

    /// Asserts that expected value is equal to stored one.
    /// - Parameters:
    ///   - expectedValue: Expected value of type `T`, where `T` is `Equatable`.
    ///   - position: Position of argument in method.
    public func assertEqual<T>(_ expectedValue: T) -> Result<Void, AssertionFailure> where T: Equatable {
        guard let castedValue = asSafe(T.self) else {
            let typeMismatchFailure: AssertionFailure = .typeMismatch(expectedType: "\(T.self)",
                                                             receivedType: storedType,
                                                             argument: position.name)
            return .failure(typeMismatchFailure)
        }

        if castedValue != expectedValue {
            let valueMismatchFailure: AssertionFailure = .valueMismatch(expectedValue: "\(expectedValue)",
                                                               receivedValue: "\(castedValue)",
                                                               argument: position.name)
            return .failure(valueMismatchFailure)
        }

        return .success(())
    }

    /// Tries to cast stored value to expected `T` type and returns result as `Optional<T>`.
    /// - Parameter expectedType: Type used for casting.
    /// - Returns: Optional result of type casting.
    public func asSafe<T>(_ expectedType: T.Type) -> T? {
        return value as? T
    }
}

extension Argument.Position {

    /// Instantiates argument position from given index.
    /// - Parameter number: Index of argument in array.
    init(_ number: Int) {
        switch number {
        case 0:
            self = .first
        case 1:
            self = .second
        case 2:
            self = .third
        case 3:
            self = .fourth
        case 4:
            self = .fifth
        case 5:
            self = .sixth
        case 6:
            self = .seventh
        case 7:
            self = .eighth
        case 8:
            self = .ninth
        default:
            self = .unknown
        }
    }
}

public enum AssertionFailure: Error {

    case nilValue
    case argumentsCountMismatch(expectedCount: Int, providedCount: Int)
    case typeMismatch(expectedType: String, receivedType: String, argument: String)
    case valueMismatch(expectedValue: String, receivedValue: String, argument: String)
    case expectedToBeCalled
    case expectedToNotBeCalled
    case expectedToBeCalledOnce(calledCount: Int)
    case expectedToBeCalledTimes(expectedCount: Int, calledCount: Int)
}

extension AssertionFailure {

    public var message: String {
        switch self {
        case .nilValue:
            return "TestDoubleFactory value must not be nil"
        case .argumentsCountMismatch(let expectedCount, let providedCount):
            return "Expected arguments count to be <\(expectedCount)> but got <\(providedCount)>"
        case .typeMismatch(let expectedType, let receivedType, let argument):
            return "Expected \(argument) to be <\(expectedType)> but got <\(receivedType)>"
        case .valueMismatch(let expectedValue, let receivedValue, let argument):
            return "Expected \(argument) to be <\(expectedValue)> but got <\(receivedValue)>"
        case .expectedToBeCalled:
            return "Expected to be called at least once"
        case .expectedToNotBeCalled:
            return "Expected to not to be called"
        case .expectedToBeCalledOnce(let calledCount):
            return "Expected to be called once but called \(calledCount) time(s)"
        case .expectedToBeCalledTimes(let expectedCount, let calledCount):
            return "Expected to be called \(expectedCount) time(s) but called \(calledCount) time(s)"
        }
    }
}

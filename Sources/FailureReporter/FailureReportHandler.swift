public struct ReportLocation {

    public let file: StaticString
    public let line: UInt
}

public protocol FailureReportHandler {

    func handleFailure(_ failure: AssertionFailure, location: ReportLocation)
    func handleFatalError(_ failure: AssertionFailure, location: ReportLocation?) -> Never
}

public struct ReportLocation {

    public let file: StaticString
    public let line: UInt
}

public protocol FailureReportHandler {

    func handleFailure(_ failure: Failure, location: ReportLocation)
    func handleFatalError(_ failure: Failure, location: ReportLocation?) -> Never
}

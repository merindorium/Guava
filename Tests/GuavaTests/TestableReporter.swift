import Guava

final class TestableReporter: FailureReportHandler {

    var passedFailureMessage: String?

    func handleFailure(_ failure: Failure, location: ReportLocation) {
        passedFailureMessage = failure.message
    }

    func handleFatalError(_ failure: Failure, location: ReportLocation?) -> Never {
        fatalError(failure.message)
    }
}

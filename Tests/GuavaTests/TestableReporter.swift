import Guava

final class TestableReporter: FailureReportHandler {

    var passedFailureMessage: String?

    func handleFailure(_ failure: AssertionFailure, location: ReportLocation) {
        passedFailureMessage = failure.message
    }

    func handleFatalError(_ failure: AssertionFailure, location: ReportLocation?) -> Never {
        fatalError(failure.message)
    }
}

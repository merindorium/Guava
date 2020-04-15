import XCTest

final class DefaultFailureReportHandler: FailureReportHandler {

    func handleFailure(_ failure: Failure, location: ReportLocation) {
        XCTFail(failure.message, file: location.file, line: location.line)
    }

    func handleFatalError(_ failure: Failure, location: ReportLocation?) -> Never {
        #if !os(Linux)
        NSException(name: .internalInconsistencyException,
                    reason: failure.message,
                    userInfo: nil).raise()
        #endif

        preconditionFailure(failure.message)
    }
}

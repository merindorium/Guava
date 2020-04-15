public final class FailureReporter {

    static var handler: FailureReportHandler {
        return reportHandler
    }

    private static var reportHandler: FailureReportHandler = DefaultFailureReportHandler()

    private init() {}

    public static func setHandler(_ handler: FailureReportHandler) {
        FailureReporter.reportHandler = handler
    }

    public static func resetToDefault() {
        FailureReporter.reportHandler = DefaultFailureReportHandler()
    }
}

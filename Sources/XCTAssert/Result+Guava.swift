extension Result where Failure == AssertionFailure {

    /// Sends report to `FailureReporter` if result is `failure`.
    /// - Parameters:
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    func reportFailure(file: StaticString, line: UInt) {
        if case .failure(let failure) = self {
            FailureReporter.handler.handleFailure(failure, location: .init(file: file, line: line))
        }
    }
}

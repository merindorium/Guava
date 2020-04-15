import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GuavaTests.allTests),
        testCase(GuavaReporterTests.allTests)
    ]
}
#endif

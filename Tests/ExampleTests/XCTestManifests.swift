import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CalculatorTestCase.allTests),
        testCase(MovieManagerTests.allTests),
        testCase(TemperatureAnalyzerTests.allTests),
        testCase(TipCalculatorTests.allTests)
    ]
}
#endif

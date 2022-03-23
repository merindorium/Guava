import Guava
import XCTest

final class GuavaReporterTests: XCTestCase {

    override func tearDown() {
        FailureReporter.resetToDefault()
    }

    func testReporterSendValueMismatchFailure() {
        let testableReporter = TestableReporter()
        FailureReporter.setHandler(testableReporter)

        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        let calcSpy = multiplierTestDouble.multiplyMethod.spy(5)
        _ = calculator.multiply(3, 3)
        XCTAssertCalled(calcSpy, with: (3, 5))

        XCTAssertEqual(testableReporter.passedFailureMessage,
                       "Expected second argument to be <5> but got <3>")
    }

    func testReporterSendTypeMismatchFailure() {
        let testableReporter = TestableReporter()
        FailureReporter.setHandler(testableReporter)

        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        let calcSpy = multiplierTestDouble.multiplyMethod.spy(5)
        _ = calculator.multiply(3, 3)
        XCTAssertCalled(calcSpy, with: ("30", 5))

        XCTAssertEqual(testableReporter.passedFailureMessage,
                       "Expected first argument to be <String> but got <Int>")
    }

    func testReporterSendArgumentsCountMismatchFailure() {
        let testableReporter = TestableReporter()
        FailureReporter.setHandler(testableReporter)

        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        let calcSpy = multiplierTestDouble.multiplyMethod.spy(5)
        _ = calculator.multiply(3, 3)
        XCTAssertCalled(calcSpy, with: (3, 5, 3))

        XCTAssertEqual(testableReporter.passedFailureMessage,
                       "Expected arguments count to be <3> but got <2>")
    }

    func testReporterSendExpectedToBeCalledFailure() {
        let testableReporter = TestableReporter()
        FailureReporter.setHandler(testableReporter)

        let multiplierTestDouble = MultiplierTestDouble()
        let calcSpy = multiplierTestDouble.multiplyMethod.spy(5)
        XCTAssertCalled(calcSpy)

        XCTAssertEqual(testableReporter.passedFailureMessage,
                       "Expected to be called at least once")
    }

    func testReporterSendExpectedToNotBeCalledFailure() {
        let testableReporter = TestableReporter()
        FailureReporter.setHandler(testableReporter)

        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        let calcSpy = multiplierTestDouble.multiplyMethod.spy(5)
        _ = calculator.multiply(3, 3)

        XCTAssertNotCalled(calcSpy)

        XCTAssertEqual(testableReporter.passedFailureMessage,
                       "Expected to not to be called")
    }

    func testReporterSendExpectedToBeCalledOnceFailure() {
        let testableReporter = TestableReporter()
        FailureReporter.setHandler(testableReporter)

        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        let calcSpy = multiplierTestDouble.multiplyMethod.spy(5)
        _ = calculator.multiply(3, 3)
        _ = calculator.multiply(3, 3)
        _ = calculator.multiply(3, 3)
        XCTAssertCalledOnce(calcSpy)

        XCTAssertEqual(testableReporter.passedFailureMessage,
                       "Expected to be called once but called 3 time(s)")
    }

    func testReporterSendExpectedToBeCalledTimesFailure() {
        let testableReporter = TestableReporter()
        FailureReporter.setHandler(testableReporter)

        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        let calcSpy = multiplierTestDouble.multiplyMethod.spy(5)
        _ = calculator.multiply(3, 3)
        _ = calculator.multiply(3, 3)
        _ = calculator.multiply(3, 3)
        XCTAssertCalled(calcSpy, times: 2)

        XCTAssertEqual(testableReporter.passedFailureMessage,
                       "Expected to be called 2 time(s) but called 3 time(s)")
    }
}

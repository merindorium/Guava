# Spying on function

There are cases when it's not enough to assert SUT's state and we need to verify its behavior (e.g. logging, reporting, notification systems). That's where `Spy` shines! 

`Spy` is a `Stub` which is very useful when you need to assert what arguments have been passed to a certain method or property. By using `invoke(arguments: [...])` method it will record incoming calls.

Let's assume that we have a `TemperatureAnalyzer` that checks incoming temp and sends a report. If temp exceeds 50 °C then it will send a failure report and successful otherwise.

```swift
enum ReportStatus: Equatable {

    case failure(temp: Int)
    case success
}

protocol TemperatureReporter {

    func report(_ reportStatus: ReportStatus)
}

final class TemperatureAnalyzer {

    private let tempThreshold = 50

    private let temperatureReporter: TemperatureReporter

    init(reporter: TemperatureReporter) {
        self.temperatureReporter = reporter
    }

    func analyzer(temperature: Int) {
        if temperature > tempThreshold {
            temperatureReporter.report(.failure(temp: temperature))
        } else {
            temperatureReporter.report(.success)
        }
    }
}
```

Now, we need to implement the `TemperatureReporter` test double.

```swift
final class TemperatureReporterTestDouble: TemperatureReporter {

    let reportMethod = TestDoubleFactory<Void>()

    func report(_ reportStatus: ReportStatus) {
        reportMethod.invoke(arguments: [reportStatus])
    }
}
```

and test cases:

```swift
final class TemperatureAnalyzerTests: XCTestCase {

    func testSuccessfulTemperatureReport() {
        let successfulTemperature = 50

        // Arrange SUT and its dependencies
        let reporterTestDouble = TemperatureReporterTestDouble()
        let tempAnalyzer = TemperatureAnalyzer(reporter: reporterTestDouble)

        // Setting up test double as a `Spy`
        let reportMethod = reporterTestDouble.reportMethod.spy(())

        // Act
        tempAnalyzer.analyzer(temperature: successfulTemperature)

        // Assert
        XCTAssertCalledOnce(reportMethod)
        XCTAssertCalled(reportMethod, with: ReportStatus.success)

        // OR
        XCTAssertEqual(reportMethod.calls.count, 1)

        let expectedCall = MethodCall(argument: ReportStatus.success)
        guard let assertionResult = reportMethod.calls.last?.assertEquals(to: expectedCall) else {
            XCTFail("Spy is not called")
            return
        }

        switch assertionResult {
        case .failure(let failure):
            XCTFail(failure.message)
        default:
            break
        }
    }

    func testFailureTemperatureReport() {
        let failureTemperature = 51

        // Arrange SUT and its dependencies
        let reporterTestDouble = TemperatureReporterTestDouble()
        let tempAnalyzer = TemperatureAnalyzer(reporter: reporterTestDouble)

        // Setting up test double as a `Spy`
        let reportMethod = reporterTestDouble.reportMethod.spy(())

        // Act
        tempAnalyzer.analyzer(temperature: failureTemperature)

        // Assert
        XCTAssertCalledOnce(reportMethod)
        XCTAssertCalled(reportMethod, with: ReportStatus.failure(temp: failureTemperature))
    }
}
```

All steps are very similar to examples with the `Stub` entity with the only exception that the `spy` method returns an instance of `Spy` that we need to save for future assertions.

As you can see in `testSuccessfulTemperatureReport` test case there are two ways of working with `Spy`:

- Use Guava's builtin `XCTAssertCalled` functions.
- Use `Spy`'s `calls` property directly with a testing library of your choice.

## XCTAssert
The first way does everything for you. It handles all assertions and reporting. Currently available functions:

- `XCTAssertCalled(_:)` - Asserts that spy was called.
- `XCTAssertNotCalled(_:)` - Asserts that spy was not called.
- `XCTAssertCalledOnce(_:)` - Asserts that spy was called only once.
- `XCTAssertCalled(_:times:)` - Asserts that spy was called a specific amount of times.
- `XCTAssertCalled(_:with:)` - Asserts that spy was called with certain arguments (up to 9 arguments).

## Manual assertion
The second way is useful when you need to combine Guava with third-party libraries.

Here is an example of how Guava could be used with [Nimble](https://github.com/Quick/Nimble).

We could create a custom `beCalled` function that will work with Guava's `MethodCall` and `Spy` entities.

```swift
import Guava
import Nimble

func beCalled<T>(with expectedCall: MethodCall) -> Predicate<Spy<T>> {
    return .define { spy -> PredicateResult in
        guard let spy = try? spy.evaluate() else {
            return .init(bool: false, message: .fail("Expected Spy to not be nil"))
        }

        guard let lastCall = spy.calls.last else {
            let failure: Failure = .expectedToBeCalled
            return .init(bool: false, message: .fail(failure.message))
        }

        if case .failure(let failure) = expectedCall.equals(to: lastCall) {
            return .init(status: .fail, message: .fail(failure.message))
        }

        return .init(status: .matches, message: .fail(Failure.expectedToBeCalled.message))
    }
}
```

And then use it with Nimble's `expect` function:
```swift
let reportMethod = reporterTestDouble.reportMethod.spy(())
// Something happend...
let expectedCall = MethodCall(argument: ReportStatus.success)
expect(reportMethod).to(beCalled(with: expectedCall))
```
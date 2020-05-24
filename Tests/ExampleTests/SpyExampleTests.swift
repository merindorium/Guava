import Guava
import XCTest

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

final class TemperatureReporterTestDouble: TemperatureReporter {

    let reportMethod = TestDoubleFactory<Void>()

    func report(_ reportStatus: ReportStatus) {
        reportMethod.invoke(arguments: [reportStatus])
    }
}

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

    static var allTests = [
        ("testSuccessfulTemperatureReport", testSuccessfulTemperatureReport),
        ("testFailureTemperatureReport", testFailureTemperatureReport)
    ]
}

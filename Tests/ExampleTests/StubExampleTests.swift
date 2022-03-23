import Guava
import XCTest

protocol TipStorage {

    func fetchAllTips() -> [Int]
}

final class TipCalculator {

    private let tipStorage: TipStorage

    init(tipStorage: TipStorage) {
        self.tipStorage = tipStorage
    }

    func sumAllTips() -> Int {
        return tipStorage.fetchAllTips().reduce(0, +)
    }
}

final class TipStorageTestDouble: TipStorage {

    let fetchAllTipsMethod = TestDoubleFactory<[Int]>()

    func fetchAllTips() -> [Int] {
        return fetchAllTipsMethod.invoke(arguments: [])
    }
}

final class TipCalculatorTests: XCTestCase {

    func testAllTipsAreSummedCorrectly() {
        // Prepare test fixtures
        let lastTips = [5, 5, 10]
        let expectedTipsSum = 20

        // Arrange SUT and its dependencies
        let tipStorageTestDouble = TipStorageTestDouble()
        let tipCalculator = TipCalculator(tipStorage: tipStorageTestDouble)

        // Set up test double as `Stub` for this test case
        tipStorageTestDouble.fetchAllTipsMethod.stub(lastTips)

        // Act
        let tipsSum = tipCalculator.sumAllTips()

        // Assert
        XCTAssertEqual(tipsSum, expectedTipsSum)
    }
}

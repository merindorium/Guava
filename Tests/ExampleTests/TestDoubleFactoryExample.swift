import Guava
import XCTest

protocol Calculator {

    var manufacturer: String { get }

    func multiply(_ lhs: Int, _ rhs: Int) -> Int
}

final class CalculatorTestDouble {

    let manufacturerProp = TestDoubleFactory<String>()
    let multiplyMethod = TestDoubleFactory<Int>()
}

extension CalculatorTestDouble: Calculator {

    var manufacturer: String {
        return manufacturerProp.invoke(arguments: [])
    }

    func multiply(_ lhs: Int, _ rhs: Int) -> Int {
        return multiplyMethod.invoke(arguments: [lhs, rhs])
    }
}

final class CalculatorTestCase: XCTestCase {

    func testMultiply() {
        let stubValue = 5
        let calculatorTestDouble = CalculatorTestDouble()

        calculatorTestDouble.multiplyMethod.stub(stubValue)

        let result = calculatorTestDouble.multiply(3, 3)
        XCTAssertEqual(result, stubValue)
    }
}

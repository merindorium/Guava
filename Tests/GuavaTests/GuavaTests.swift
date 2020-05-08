import Guava
import XCTest

final class GuavaTests: XCTestCase {

    func testMethodStub() {
        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        multiplierTestDouble.multiplyMethod.stub(5)

        let result = calculator.multiply(3, 3)
        XCTAssertEqual(result, 5)
    }

    func testSpyCalled() {
        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(10)

        let result = calculator.multiply(3, 3)
        XCTAssertEqual(result, 10)
        XCTAssertCalledOnce(spy)
    }

    func testSpyNotCalled() {
        let multiplierTestDouble = MultiplierTestDouble()
        _ = Calculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(10)

        XCTAssertNotCalled(spy)
    }

    func testSpyCalledWithArguments() {
        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(10)

        _ = calculator.multiply(3, 3)

        XCTAssertCalled(spy, with: (3, 3))
    }

    func testFake() {
        let multiplierTestDouble = MultiplierTestDouble()
        let calculator = Calculator(multiplier: multiplierTestDouble)

        multiplierTestDouble.multiplyMethod.fake { args in
            let (left, right) = args.as(Int.self, Int.self)

            return left + right
        }

        let result = calculator.multiply(3, 3)
        XCTAssertEqual(result, 6)
    }

    static var allTests = [
        ("testMethodStub", testMethodStub),
        ("testSpyCalled", testSpyCalled),
        ("testSpyNotCalled", testSpyNotCalled),
        ("testSpyCalledWithArguments", testSpyCalledWithArguments),
        ("testFake", testFake)
    ]
}

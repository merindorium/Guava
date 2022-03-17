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

    func testMethodThrowingStubCalls() throws {
        let multiplierTestDouble = ThrowingMultiplierTestDouble()
        let calculator = ThrowingCalculator(multiplier: multiplierTestDouble)

        multiplierTestDouble.multiplyMethod.stub(5)

        let result = try calculator.multiply(3, 3)
        XCTAssertEqual(result, 5)
    }

    func testMethodThrowingStubThrows() {
        let multiplierTestDouble = ThrowingMultiplierTestDouble()
        let calculator = ThrowingCalculator(multiplier: multiplierTestDouble)

        multiplierTestDouble.multiplyMethod.stub(NSError.testableError)

        XCTAssertThrowsError(try calculator.multiply(3, 3))
    }

    func testThrowingSpyCalled() throws {
        let multiplierTestDouble = ThrowingMultiplierTestDouble()
        let calculator = ThrowingCalculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(10)

        let result = try calculator.multiply(3, 3)
        XCTAssertEqual(result, 10)
        XCTAssertCalledOnce(spy)
    }

    func testThrowingSpyNotCalled() {
        let multiplierTestDouble = ThrowingMultiplierTestDouble()
        _ = ThrowingCalculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(10)

        XCTAssertNotCalled(spy)
    }

    func testThrowingSpyThrows() {
        let multiplierTestDouble = ThrowingMultiplierTestDouble()
        let calculator = ThrowingCalculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(NSError.testableError)

        XCTAssertThrowsError(try calculator.multiply(3, 3))
        XCTAssertCalledOnce(spy)
    }

    func testThrowingSpyCalledWithArguments() throws {
        let multiplierTestDouble = ThrowingMultiplierTestDouble()
        let calculator = ThrowingCalculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(10)

        _ = try calculator.multiply(3, 3)

        XCTAssertCalled(spy, with: (3, 3))
    }

    func testThrowingFakeCalled() throws {
        let multiplierTestDouble = ThrowingMultiplierTestDouble()
        let calculator = ThrowingCalculator(multiplier: multiplierTestDouble)

        multiplierTestDouble.multiplyMethod.fake { args in
            let (left, right) = args.as(Int.self, Int.self)

            return left + right
        }

        let result = try calculator.multiply(3, 3)
        XCTAssertEqual(result, 6)
    }

    func testThrowingFakeThrows() {
        let multiplierTestDouble = ThrowingMultiplierTestDouble()
        let calculator = ThrowingCalculator(multiplier: multiplierTestDouble)

        multiplierTestDouble.multiplyMethod.fake { _ in
            throw NSError.testableError
        }

        XCTAssertThrowsError(try calculator.multiply(3, 3))
    }

    static var allTests = [
        ("testMethodStub", testMethodStub),
        ("testSpyCalled", testSpyCalled),
        ("testSpyNotCalled", testSpyNotCalled),
        ("testSpyCalledWithArguments", testSpyCalledWithArguments),
        ("testFake", testFake),
        ("testMethodThrowingStubCalls", testMethodThrowingStubCalls),
        ("testMethodThrowingStubThrows", testMethodThrowingStubThrows),
        ("testThrowingSpyCalled", testThrowingSpyCalled),
        ("testThrowingSpyNotCalled", testThrowingSpyNotCalled),
        ("testThrowingSpyThrows", testThrowingSpyThrows),
        ("testThrowingSpyCalledWithArguments", testThrowingSpyCalledWithArguments),
        ("testThrowingFakeCalled", testThrowingFakeCalled),
        ("testThrowingFakeThrows", testThrowingFakeThrows)
    ]
}

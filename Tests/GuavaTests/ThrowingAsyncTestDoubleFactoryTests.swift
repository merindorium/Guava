import Guava
import XCTest

@available(iOS 13, macOS 10.15, *)
final class ThrowingAsyncTestDoubleFactoryTests: XCTestCase {

    func testMethodThrowingAsyncStubCalls() async throws {
        let multiplierTestDouble = ThrowingAsyncMultiplierTestDouble()
        let calculator = ThrowingAsyncCalculator(multiplier: multiplierTestDouble)

        await multiplierTestDouble.multiplyMethod.stub(5, delayInNanoseconds: 100_000_000)

        let result = try await calculator.multiply(3, 3)
        XCTAssertEqual(result, 5)
    }

    func testMethodThrowingAsyncStubThrows() async {
        let multiplierTestDouble = ThrowingAsyncMultiplierTestDouble()
        let calculator = ThrowingAsyncCalculator(multiplier: multiplierTestDouble)

        await multiplierTestDouble.multiplyMethod.stub(NSError.testableError, delayInNanoseconds: 100_000_000)

        do {
            _ = try await calculator.multiply(3, 3)
            XCTFail("Method expected to throw")
        } catch {
            XCTAssertThrowsError(try {
                throw error
            }())
        }
    }

    func testThrowingAsyncSpyCalled() async throws {
        let multiplierTestDouble = ThrowingAsyncMultiplierTestDouble()
        let calculator = ThrowingAsyncCalculator(multiplier: multiplierTestDouble)

        let spy = await multiplierTestDouble.multiplyMethod.spy(10, delayInNanoseconds: 100_000_000)

        let result = try await calculator.multiply(3, 3)
        XCTAssertEqual(result, 10)
        await XCTAssertCalledOnce(spy)
    }

    func testThrowingAsyncSpyNotCalled() async {
        let multiplierTestDouble = ThrowingAsyncMultiplierTestDouble()
        _ = ThrowingAsyncCalculator(multiplier: multiplierTestDouble)

        let spy = await multiplierTestDouble.multiplyMethod.spy(10)

        await XCTAssertNotCalled(spy)
    }

    func testThrowingAsyncSpyThrows() async {
        let multiplierTestDouble = ThrowingAsyncMultiplierTestDouble()
        let calculator = ThrowingAsyncCalculator(multiplier: multiplierTestDouble)

        let spy = await multiplierTestDouble.multiplyMethod.spy(NSError.testableError, delayInNanoseconds: 100_000_000)

        do {
            _ = try await calculator.multiply(3, 3)
            XCTFail("Expected method to throw")
        } catch {
            XCTAssertThrowsError(try {
                throw error
            }())
        }
        await XCTAssertCalledOnce(spy)
    }

    func testThrowingAsyncSpyCalledWithArguments() async throws {
        let multiplierTestDouble = ThrowingAsyncMultiplierTestDouble()
        let calculator = ThrowingAsyncCalculator(multiplier: multiplierTestDouble)

        let spy = await multiplierTestDouble.multiplyMethod.spy(10, delayInNanoseconds: 100_000_000)

        _ = try await calculator.multiply(3, 3)

        await XCTAssertCalled(spy, with: (3, 3))
    }

    func testThrowingAsyncFakeCalled() async throws {
        let multiplierTestDouble = ThrowingAsyncMultiplierTestDouble()
        let calculator = ThrowingAsyncCalculator(multiplier: multiplierTestDouble)

        await multiplierTestDouble.multiplyMethod.fake { args in
            do {
                try await Task.sleep(nanoseconds: 100_000_000)
            } catch {
                XCTFail("Falied to delay closure")
            }

            let (left, right) = args.as(Int.self, Int.self)

            return left + right
        }

        let result = try await calculator.multiply(3, 3)
        XCTAssertEqual(result, 6)
    }

    func testThrowingAsyncFakeThrows() async {
        let multiplierTestDouble = ThrowingAsyncMultiplierTestDouble()
        let calculator = ThrowingAsyncCalculator(multiplier: multiplierTestDouble)

        await multiplierTestDouble.multiplyMethod.fake { _ in
            do {
                try await Task.sleep(nanoseconds: 100_000_000)
            } catch {
                XCTFail("Falied to delay closure")
            }
            throw NSError.testableError
        }

        do {
            _ = try await calculator.multiply(3, 3)
        } catch {
            XCTAssertThrowsError(try {
                throw error
            }())
        }
    }
}

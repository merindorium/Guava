import Guava
import XCTest

@available(iOS 13, macOS 10.15, *)
final class AsyncTestDoubleFactoryTests: XCTestCase {

    func testMethodStubAsync() async {
        let multiplierTestDouble = AsyncMultiplierTestDouble()
        let calculator = AsyncCalculator(multiplier: multiplierTestDouble)

        multiplierTestDouble.multiplyMethod.stub(5, delayInNanoseconds: 100_000_000)

        let result = await calculator.multiply(3, 3)
        XCTAssertEqual(result, 5)
    }

    func testSpyCalledAsync() async {
        let multiplierTestDouble = AsyncMultiplierTestDouble()
        let calculator = AsyncCalculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(10, delayInNanoseconds: 100_000_000)

        let result = await calculator.multiply(3, 3)
        XCTAssertEqual(result, 10)
        XCTAssertCalledOnce(spy)
    }

    func testSpyNotCalledAsync() {
        let multiplierTestDouble = AsyncMultiplierTestDouble()
        _ = AsyncCalculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(10, delayInNanoseconds: 100_000_000)

        XCTAssertNotCalled(spy)
    }

    func testSpyCalledWithArgumentsAsync() async {
        let multiplierTestDouble = AsyncMultiplierTestDouble()
        let calculator = AsyncCalculator(multiplier: multiplierTestDouble)

        let spy = multiplierTestDouble.multiplyMethod.spy(10, delayInNanoseconds: 100_000_000)

        _ = await calculator.multiply(3, 3)

        XCTAssertCalled(spy, with: (3, 3))
    }

    func testFakeAsync() async {
        let multiplierTestDouble = AsyncMultiplierTestDouble()
        let calculator = AsyncCalculator(multiplier: multiplierTestDouble)

        multiplierTestDouble.multiplyMethod.fake { args in
            do {
                try await Task.sleep(nanoseconds: 100_000_000)
            } catch {
                XCTFail("Falied to delay closure")
            }

            let (left, right) = args.as(Int.self, Int.self)

            return left + right
        }

        let result = await calculator.multiply(3, 3)
        XCTAssertEqual(result, 6)
    }
}

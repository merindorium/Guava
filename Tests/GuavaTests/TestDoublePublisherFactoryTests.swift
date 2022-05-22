import Guava
import XCTest

@available(iOS 13, macOS 10.15, *)
final class TestDoublePublisherFactoryTests: XCTestCase {

    func testMethodStub()  {
        let testDouble = MultiplierTestDoublePublisher()
        let calculator = ReactiveCalculator(multiplier: testDouble)

        testDouble.multiplyMethod.stub(.success(5))

        let exp = expectation(description: "Waiting ...")
        var output: Int!
        let cancellable = calculator.multiply(3, 3).sink { completion in
            if case .failure(_) = completion {
                XCTFail("Publisher completed with failure when it shouldn't")
            }
        } receiveValue: { value in
            output = value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(output, 5)
        cancellable.cancel()
    }

    func testMethodStubWithError() {
        let testDouble = MultiplierTestDoublePublisher()
        let calculator = ReactiveCalculator(multiplier: testDouble)

        testDouble.multiplyMethod.stub(.failure(NSError.testableError))

        let exp = expectation(description: "Waiting ...")
        let cancellable = calculator.multiply(3, 3).sink { completion in
            if case .failure(_) = completion {
                exp.fulfill()
            }
        } receiveValue: { _ in
            XCTFail("Publisher expected to complete with failure")
        }

        wait(for: [exp], timeout: 1)
        cancellable.cancel()
    }

    func testSpyCalled() {
        let testDouble = MultiplierTestDoublePublisher()
        let calculator = ReactiveCalculator(multiplier: testDouble)

        let spy = testDouble.multiplyMethod.spy(.success(10))
        
        let exp = expectation(description: "Waiting ...")
        var output: Int!
        let cancellable = calculator.multiply(3, 3).sink { completion in
            if case .failure(_) = completion {
                XCTFail("Publisher completed with failure when it shouldn't")
            }
        } receiveValue: { value in
            output = value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)

        XCTAssertEqual(output, 10)
        XCTAssertCalledOnce(spy)
        cancellable.cancel()
    }

    func testSpyNotCalled() {
        let testDouble = MultiplierTestDoublePublisher()
        _ = ReactiveCalculator(multiplier: testDouble)

        let spy = testDouble.multiplyMethod.spy(.success(10))

        XCTAssertNotCalled(spy)
    }

    func testSpyCompleteWithFailure() {
        let testDouble = MultiplierTestDoublePublisher()
        let calculator = ReactiveCalculator(multiplier: testDouble)

        let spy = testDouble.multiplyMethod.spy(.failure(NSError.testableError))

        let exp = expectation(description: "Waiting ...")
        let cancellable = calculator.multiply(3, 3).sink { completion in
            if case .failure(_) = completion {
                exp.fulfill()
            }
        } receiveValue: { _ in
            XCTFail("Publisher expected to complete with failure")
        }

        wait(for: [exp], timeout: 1)
        
        XCTAssertCalledOnce(spy)
        cancellable.cancel()
    }

    func testSpyCalledWithArguments() {
        let testDouble = MultiplierTestDoublePublisher()
        let calculator = ReactiveCalculator(multiplier: testDouble)

        let spy = testDouble.multiplyMethod.spy(.success(10))

        let exp = expectation(description: "Waiting ...")
        let cancellable = calculator.multiply(3, 3).sink { completion in
            if case .failure(_) = completion {
                XCTFail("Publisher completed with failure when it shouldn't")
            }
        } receiveValue: { _ in
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)

        XCTAssertCalled(spy, with: (3, 3))
        cancellable.cancel()
    }

    func testFakeCalled() async throws {
        let testDouble = MultiplierTestDoublePublisher()
        let calculator = ReactiveCalculator(multiplier: testDouble)

        testDouble.multiplyMethod.fake { args in
            let (left, right) = args.as(Int.self, Int.self)

            return Result.Publisher(left + right).eraseToAnyPublisher()
        }

        let exp = expectation(description: "Waiting ...")
        var output: Int!
        let cancellable = calculator.multiply(3, 3).sink { completion in
            if case .failure(_) = completion {
                XCTFail("Publisher completed with failure when it shouldn't")
            }
        } receiveValue: { value in
            output = value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(output, 6)
        cancellable.cancel()
    }

    func testFakeCompletesWithError() async {
        let testDouble = MultiplierTestDoublePublisher()
        let calculator = ReactiveCalculator(multiplier: testDouble)

        testDouble.multiplyMethod.fake { _ in
            Result.Publisher(NSError.testableError).eraseToAnyPublisher()
        }

        let exp = expectation(description: "Waiting ...")
        let cancellable = calculator.multiply(3, 3).sink { completion in
            if case .failure(_) = completion {
                exp.fulfill()
            }
        } receiveValue: { _ in
            XCTFail("Publisher expected to complete with failure")
        }

        wait(for: [exp], timeout: 1)
        
        cancellable.cancel()
    }
}

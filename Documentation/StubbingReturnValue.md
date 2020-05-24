# Stubbing return value

`Stub` is the most commonly used entity. It provides ***predefined answers*** to incoming calls.

To create `Stub` we need to ask `TestDoubleFactory` to create one. 

Let's say we have a `TipCalculator` that can sum all tips.
It has only `TipStorage` as a dependency which is used to fetch all earned tips.

```swift
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
```

We want to test that the calculator's `sumAllTips` method works properly and returns a correct sum of all earned tips.

Firstly, we need to resolve `TipStorage`. Let's create a test double class that conforms to `TipStorage` protocol.

```swift
import Guava

final class TipStorageTestDouble: TipStorage {

    let fetchAllTipsMethod = TestDoubleFactory<[Int]>()

    func fetchAllTips() -> [Int] {
        return fetchAllTipsMethod.invoke(arguments: [])
    }
}
```

As you can see we've used `TestDoubleFactory` to instantiate a `fetchAllTipsMethod` property that works as a test double for the `fetchAllTips` method. This property should not be `private` because we need to have access to it in our test cases.

At last, let's arrange our test case!

```swift
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
```

Here we've used the `stub` method of `fetchAllTipsMethod` thus we created `Stub` that will always return predefined `lastTips` value. If we need to return another value then we use the `stub` method again and it will rewrite previous value with the new one.
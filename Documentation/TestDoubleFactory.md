# Setting up test case dependencies with TestDoubleFactory

This is the core component of this library. It is used to create all test doubles.

The standard approach implies that each factory **represents a single method or property**.

> ⚠️ Warning: `TestDoubleFactory` has no value by default. You should explicitly create test double to make it work or it will cause a test failure.

```swift
import Guava

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
```

As you can see from example, `TestDoubleFactory` has an `invoke(arguments: [Any])` method. This method consumes incoming arguments and returns the predefined value. It's not necessary to send arguments to this method but it will help `Spy` and `Fake` test doubles to work properly.
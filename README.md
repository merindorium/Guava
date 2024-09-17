# Guava 

Guava helps you to make your unit tests more flexible. It allows you to replace parts of your system under test with a test double objects.

----

![build](https://github.com/merindorium/Guava/workflows/build/badge.svg?branch=master)
![Swift 5.x](https://img.shields.io/badge/Swift-5.x-orange.svg)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20osx%20%7C%20linux-lightgray.svg)
![version](https://img.shields.io/github/v/tag/merindorium/guava?label=version)

Table of Contents
=================

- [Usage](#usage)
- [Documentation](#documentation)
- [Installation](#installation)

# Features

Guava provides several types of test doubles:

- Stub
- Spy
- Fake

# Usage

```swift
import Guava
import XCTest

protocol Calculator {

    func multiply(_ lhs: Int, _ rhs: Int) -> Int
}

final class CalculatorTestDouble: Calculator {

    let multiplyMethod = TestDoubleFactory<Int>()

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
```

# Documentation

See [Documentation](Documentation) section.

# Installation

## Swift Package Manager

To use `Guava` with SPM update your `Package.swift`.

```swift
import PackageDescription

let package = Package(
    name: "ExampleProject",
    dependencies: [
        .package(url: "https://github.com/merindorium/Guava.git", from: "v1.2.0")
    ],
    ...
)

```

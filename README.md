# Guava 

![build](https://github.com/merindorium/Guava/workflows/build/badge.svg?branch=master)
![Swift 5.x](https://img.shields.io/badge/Swift-5.x-orange.svg)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20osx%20%7C%20linux-lightgray.svg)
![version 1.0.0](https://img.shields.io/badge/version-1.0.0-blue.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Table of Contents
=================

* [Features](#features)
* [Usage](#usage)
  * [TestDoubleFactory](#testdoublefactory)
  * [Stub](#stub)
  * [Spy](#spy)
  * [Fake](#fake)
* [Installation](#installation)

# Features

Guava provides several types of test doubles:

- Stub
- Spy
- Fake

# Usage

### API Stability

Current API is not stable yet.

### Fatal failures behavior

This guide mentions **`fatal failures`** during some strict operations. These failures has different behavior on Linux and other platforms (see `DefaultFailureReportHandler` class).

- On non Linux platforms (e.g. iOS, MacOS, etc) `NSException` will be raised. Due to it's nature it will break only current test case and whole test bundle will not be stopped.
- On Linux there is no such option, that's why we are stopping whole bundle with `preconditionFailure`.

## TestDoubleFactory

This is the core component of this library. It is used to create all test doubles.

The standard approach implies that each factory represents a single method or property.

> ⚠️ Warning: `TestDoubleFactory` has no value by default. You should explicitly create test double to make it work or it will cause a test failure.

```swift
class MultiplierTestDouble {

    let multiplyMethod = TestDoubleFactory<Int>()
    let multiplierOwnerProp = TestDoubleFactory<String>()

    var multiplierOwner: String {
        multiplierOwnerProp.invoke(arguments: [])
    }

    func multiply(_ a: Int, _ b: Int) -> Int {
        return multiplyMethod.invoke(arguments: [a, b])
    }
}
```
As you can see from example, `TestDoubleFactory` has an `invoke(arguments: [Any])` method. This method consumes incoming arguments and returns predefined value. It's not necessary to send arguments to this method but it will help `Spy` and `Fake` test doubles to work properly.

## Stub

`Stub` is the most commonly used entity. It provides predefined answers to incoming calls.

To create `Stub` we need to ask certain `TestDoubleFactory` to create one. Let's take `MultiplierTestDouble` class from example above.

```swift
func testMultiplyStub() {

	let multiplierTestDouble = MultiplierTestDouble()

	multiplierTestDouble.multiplyMethod.stub(5)

	let result = multiplierTestDouble.multiply(3, 3)
	XCTAssertEqual(result, 5) // Returns `true`

}
```

## Spy

`Spy` is a `Stub` which is very useful when you need to assert what arguments has been passed to certain method or property. By using `invoke([...])` method `Spy` will record incoming values.

> ℹ️ Note: Currently `Spy` each call will rewrite call arguments thus only the last one will be available.

There is two ways of working with `Spy`:

- Use Guava's builtin `XCTAssertCalled` functions
- Use `Spy`'s `callCount` and `callArguments` properties directly with testing library of your choice.

#### Asserts that `Spy` was called

```swift
func testSpyCalled() {
    let multiplierTestDouble = MultiplierTestDouble()

    let spy = multiplierTestDouble.multiplyMethod.spy(10)

    let result = multiplierTestDouble.multiply(3, 3)
    XCTAssertEqual(result, 10)

    XCTAssertCalledOnce(spy)
    // OR
    XCTAssertEqual(spy.callCount, 1)
}
```
#### Asserts that `Spy` was called with certain arguments

```swift
func testSpyCalledWithArguments() {
    let multiplierTestDouble = MultiplierTestDouble()

    let spy = multiplierTestDouble.multiplyMethod.spy(10)

    let result = multiplierTestDouble.multiply(3, 3)

	 XCTAssertCalled(spy, with: (3, 3))
	 // OR
	 let (a, b) = spy.calledArguments.as(Int.self, Int.self)
	 XCTAssertEqual(a, 3)
	 XCTAssertEqual(b, 3)
}
```

## Fake

`Fake` is helpful if you want to have a control and inject some logic to test double. With `Fake` you are able to receive all incoming arguments and cast them to expected types.

> ⚠️ Warning: Use `[Argument]` method `as` with caution. It casts type strictly and will raise a fatal failure if types are not matching.

```swift
func testFake() {
    let multiplierTestDouble = MultiplierTestDouble()

    multiplierTestDouble.multiplyMethod.fake { args in
        let (a, b) = args.as(Int.self, Int.self)

        return a + b
    }

    let result = multiplierTestDouble.multiply(3, 3)
    XCTAssertEqual(result, 6)
}
```

# Installation

## Carthage

Update your `Cartfile` with:

```
github "merindorium/Guava"
```

## Swift Package Manager

To use `Guava` with SPM update your `Package.swift`.

```swift
import PackageDescription

let package = Package(
    name: "ExampleProject",
    dependencies: [
        .package(url: "https://github.com/merindorium/Guava.git", from: "v1.0.0")
    ],
    ...
)

```

## Manual

> ⚠️ This will install `Carthage` on your system

You could manually build Guava for iOS and MacOS by using:

1. `make release_tooling`
2. `make carthage_build`

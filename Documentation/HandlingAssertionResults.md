# Handling assertion results

This section describes how to handle assertion results that Guava generates. 

Guava uses `Result<Void, AssertionFailure>` to express its assertion results.
To report failed assertions it relies on `FailureReporter` singleton.

## Failures handling

If you are using `XCTAssert...` functions then all reporting logic is handled automatically by `DefaultFailureReportHandler`.

If you are trying to use Guava manually or combine it with a third-party library then it's up to you how to handle assertion results. All you need is to process `Result<Void, AssertionFailure>` and use the `message` property of the `AssertionFailure` entity to render failure information.

Example from `Spy` section:
```swift
let assertionResult = reportMethod.calls.last?.assertEquals(to: expectedCall)

switch assertionResult {
case .failure(let failure):
    XCTFail(failure.message)
default:
    break
}
```

## Fatal errors handling

There are some situations that are handled as fatal errors:

- Empty `TestDoubleFactory` (no stub, spy or fake provided).
- Failed strict casting with `Array<Argument>.as(...)` method.

These errors have different behavior on Linux and other platforms (see `DefaultFailureReportHandler` class).

- On non-Linux platforms (e.g. iOS, macOS, etc) `NSException` will be raised. Due to its nature it will break only the current test case and the whole test bundle will not be stopped.
- On Linux there is no such option, that's why we are stopping the whole bundle with `preconditionFailure`.


## Overriding reporter

Guava gives you an ability to use any reporter instead of default one with `XCTFail` function. 

You only need to create a new report handler that implements `FailureReportHandler` protocol. Then, you should use the `setHandler` method of `FailureReporter` to set a new report handler. 

If you want to reset the handler back to default then you could use the `resetToDefault` method.
// swiftlint:disable file_length

/// Asserts that spy was called.
/// - Parameters:
///   - spy: Spy to assert.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out>(_ spy: Spy<Out>, file: StaticString = #file, line: UInt = #line) {
    if spy.calls.isEmpty {
        FailureReporter.handler.handleFailure(.expectedToBeCalled,
                                              location: ReportLocation(file: file, line: line))
    }
}

/// Asserts that spy was not called.
/// - Parameters:
///   - spy: Spy to assert.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertNotCalled<Out>(_ spy: Spy<Out>, file: StaticString = #file, line: UInt = #line) {
    if !spy.calls.isEmpty {
        FailureReporter.handler.handleFailure(.expectedToNotBeCalled,
                                              location: ReportLocation(file: file, line: line))
    }
}

/// Asserts that spy was called only once.
/// - Parameters:
///   - spy: Spy to assert.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalledOnce<Out>(_ spy: Spy<Out>, file: StaticString = #file, line: UInt = #line) {
    if spy.calls.count != 1 {
        FailureReporter.handler.handleFailure(.expectedToBeCalledOnce(calledCount: spy.calls.count),
                                              location: ReportLocation(file: file, line: line))
    }
}

/// Asserts that spy was called specific amount of times.
/// - Parameters:
///   - spy: Spy to assert.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out>(_ spy: Spy<Out>, times: Int, file: StaticString = #file, line: UInt = #line) {
    if spy.calls.count != times {
        FailureReporter.handler.handleFailure(.expectedToBeCalledTimes(expectedCount: times,
                                                                       calledCount: spy.calls.count),
                                              location: ReportLocation(file: file, line: line))
    }
}

/// Asserts that spy was called with one argument.
/// - Parameters:
///   - spy: Spy to assert.
///   - argument: An argument of type `A`, where `A` is `Equatable`.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out, A>(_ spy: Spy<Out>,
                                    with argument: A,
                                    file: StaticString = #file,
                                    line: UInt = #line) where A: Equatable {
    XCTAssertCalled(spy, file: file, line: line)
    spy.calls.last?.assertCalled(with: argument).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with two arguments.
/// - Parameters:
///   - spy: Spy to assert.
///   - arguments: A tuple of types `A`, `B`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out, A, B>(_ spy: Spy<Out>,
                                       with arguments: (A, B),
                                       file: StaticString = #file,
                                       line: UInt = #line)
    where A: Equatable, B: Equatable {
        XCTAssertCalled(spy, file: file, line: line)
        spy.calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with three arguments.
/// - Parameters:
///   - spy: Spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out, A, B, C>(_ spy: Spy<Out>,
                                          with arguments: (A, B, C),
                                          file: StaticString = #file,
                                          line: UInt = #line)
    where A: Equatable, B: Equatable, C: Equatable {
        XCTAssertCalled(spy, file: file, line: line)
        spy.calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with four arguments.
/// - Parameters:
///   - spy: Spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out, A, B, C, D>(_ spy: Spy<Out>,
                                             with arguments: (A, B, C, D),
                                             file: StaticString = #file,
                                             line: UInt = #line)
    where A: Equatable, B: Equatable, C: Equatable, D: Equatable {
        XCTAssertCalled(spy, file: file, line: line)
        spy.calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with five arguments.
/// - Parameters:
///   - spy: Spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out, A, B, C, D, E>(_ spy: Spy<Out>,
                                                with arguments: (A, B, C, D, E),
                                                file: StaticString = #file,
                                                line: UInt = #line)
    where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable {
        XCTAssertCalled(spy, file: file, line: line)
        spy.calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with six arguments.
/// - Parameters:
///   - spy: Spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out, A, B, C, D, E, F>(_ spy: Spy<Out>,
                                                   with arguments: (A, B, C, D, E, F),
                                                   file: StaticString = #file,
                                                   line: UInt = #line)
    where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable {
        XCTAssertCalled(spy, file: file, line: line)
        spy.calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with seven arguments.
/// - Parameters:
///   - spy: Spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out, A, B, C, D, E, F, G>(_ spy: Spy<Out>,
                                                      with arguments: (A, B, C, D, E, F, G),
                                                      file: StaticString = #file,
                                                      line: UInt = #line)
    where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable {
        XCTAssertCalled(spy, file: file, line: line)
        spy.calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with eight arguments.
/// - Parameters:
///   - spy: Spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out, A, B, C, D, E, F, G, H>(_ spy: Spy<Out>,
                                                         with arguments: (A, B, C, D, E, F, G, H),
                                                         file: StaticString = #file,
                                                         line: UInt = #line)
    where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable,
    H: Equatable {
        XCTAssertCalled(spy, file: file, line: line)
        spy.calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with nine arguments.
/// - Parameters:
///   - spy: Spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, `I`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertCalled<Out, A, B, C, D, E, F, G, H, I>(_ spy: Spy<Out>,
                                                            with arguments: (A, B, C, D, E, F, G, H, I),
                                                            file: StaticString = #file,
                                                            line: UInt = #line)
    where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable,
    H: Equatable, I: Equatable {
        XCTAssertCalled(spy, file: file, line: line)
        spy.calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called.
/// - Parameters:
///   - spy: Async spy to assert.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out>(_ spy: AsyncSpy<Out>, file: StaticString = #file, line: UInt = #line) async {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
}

/// Asserts that spy was not called.
/// - Parameters:
///   - spy: Async spy to assert.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertNotCalled<Out>(_ spy: AsyncSpy<Out>, file: StaticString = #file, line: UInt = #line) async {
    let calls = await spy.calls
    if !calls.isEmpty {
        FailureReporter.handler.handleFailure(.expectedToNotBeCalled,
                                              location: ReportLocation(file: file, line: line))
    }
}

/// Asserts that spy was called only once.
/// - Parameters:
///   - spy: Async spy to assert.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalledOnce<Out>(_ spy: AsyncSpy<Out>, file: StaticString = #file, line: UInt = #line) async {
    let calls = await spy.calls
    if calls.count != 1 {
        FailureReporter.handler.handleFailure(.expectedToBeCalledOnce(calledCount: calls.count),
                                              location: ReportLocation(file: file, line: line))
    }
}

/// Asserts that spy was called specific amount of times.
/// - Parameters:
///   - spy: Async spy to assert.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out>(
    _ spy: AsyncSpy<Out>,
    times: Int,
    file: StaticString = #file,
    line: UInt = #line
) async {
    let calls = await spy.calls
    if calls.count != times {
        FailureReporter.handler.handleFailure(.expectedToBeCalledTimes(expectedCount: times,
                                                                       calledCount: calls.count),
                                              location: ReportLocation(file: file, line: line))
    }
}

/// Asserts that spy was called with one argument.
/// - Parameters:
///   - spy: Async spy to assert.
///   - argument: An argument of type `A`, where `A` is `Equatable`.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out, A>(
    _ spy: AsyncSpy<Out>,
    with argument: A,
    file: StaticString = #file,
    line: UInt = #line
) async where A: Equatable {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
    calls.last?.assertCalled(with: argument).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with two arguments.
/// - Parameters:
///   - spy: Async spy to assert.
///   - arguments: A tuple of types `A`, `B`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out, A, B>(
    _ spy: AsyncSpy<Out>,
    with arguments: (A, B),
    file: StaticString = #file,
    line: UInt = #line
) async where A: Equatable, B: Equatable {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
    calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with three arguments.
/// - Parameters:
///   - spy: Async spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out, A, B, C>(
    _ spy: AsyncSpy<Out>,
    with arguments: (A, B, C),
    file: StaticString = #file,
    line: UInt = #line
) async where A: Equatable, B: Equatable, C: Equatable {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
    calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with four arguments.
/// - Parameters:
///   - spy: Async spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out, A, B, C, D>(
    _ spy: AsyncSpy<Out>,
    with arguments: (A, B, C, D),
    file: StaticString = #file,
    line: UInt = #line
) async where A: Equatable, B: Equatable, C: Equatable, D: Equatable {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
    calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with five arguments.
/// - Parameters:
///   - spy: Async spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out, A, B, C, D, E>(
    _ spy: AsyncSpy<Out>,
    with arguments: (A, B, C, D, E),
    file: StaticString = #file,
    line: UInt = #line
) async where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
    calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with six arguments.
/// - Parameters:
///   - spy: Async spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out, A, B, C, D, E, F>(
    _ spy: AsyncSpy<Out>,
    with arguments: (A, B, C, D, E, F),
    file: StaticString = #file,
    line: UInt = #line
) async where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
    calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with seven arguments.
/// - Parameters:
///   - spy: Async spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out, A, B, C, D, E, F, G>(
    _ spy: AsyncSpy<Out>,
    with arguments: (A, B, C, D, E, F, G),
    file: StaticString = #file,
    line: UInt = #line
) async where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
    calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with eight arguments.
/// - Parameters:
///   - spy: Async spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out, A, B, C, D, E, F, G, H>(
    _ spy: AsyncSpy<Out>,
    with arguments: (A, B, C, D, E, F, G, H),
    file: StaticString = #file,
    line: UInt = #line
) async
where
    A: Equatable,
    B: Equatable,
    C: Equatable,
    D: Equatable,
    E: Equatable,
    F: Equatable,
    G: Equatable,
    H: Equatable {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
    calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that spy was called with nine arguments.
/// - Parameters:
///   - spy: Async spy to assert.
///   - arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, `I`, where these types are `Equatable`
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
@available(iOS 13, macOS 10.15, *)
public func XCTAssertCalled<Out, A, B, C, D, E, F, G, H, I>(
    _ spy: AsyncSpy<Out>,
    with arguments: (A, B, C, D, E, F, G, H, I),
    file: StaticString = #file,
    line: UInt = #line
) async
where
    A: Equatable,
    B: Equatable,
    C: Equatable,
    D: Equatable,
    E: Equatable,
    F: Equatable,
    G: Equatable,
    H: Equatable,
    I: Equatable {
    let calls = await spy.calls
    XCTAssertCalled(calls, file: file, line: line)
    calls.last?.assertCalled(with: arguments).reportFailure(file: file, line: line)
}

/// Asserts that `recordedMethodCalls` are not empty.
/// This method exists since `AsyncSpy` could be updated between cheking its recorded method property.
/// - Parameters:
///   - recordedMethodCalls: An array of method calls recorded by `Spy`.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
private func XCTAssertCalled(
    _ recordedMethodCalls: [RecordedMethodCall],
    file: StaticString,
    line: UInt
) {
    if recordedMethodCalls.isEmpty {
        FailureReporter.handler.handleFailure(.expectedToBeCalled,
                                              location: ReportLocation(file: file, line: line))
    }
}

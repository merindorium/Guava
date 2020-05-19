/// Represents method call that is recorded during `Spy` invocation.
public struct RecordedMethodCall {

    /// Maximum quantity of arguments which could be recorded.
    static let argumentsLimit = 9

    /// Recorded arguments.
    public let arguments: [Argument]

    init(arguments: [Any]) {
        self.arguments = arguments
            .prefix(RecordedMethodCall.argumentsLimit)
            .enumerated()
            .map { Argument(value: $0.element, position: .init($0.offset)) }
    }

    /// Asserts that recorded call is equal to expected one.
    /// - Parameter methodCall: Method call to compare with.
    /// - Returns: Quality result.
    public func assertEquals(to methodCall: MethodCall) -> Result<Void, AssertionFailure> {
        return methodCall.assertEquals(to: self)
    }
}

extension RecordedMethodCall {

    /// Asserts that recorded call has expected argument.
    /// - Parameter argument: An argument of type `A`, where `A` is `Equatable`.
    /// - Returns: Assertion result.
    public func assertCalled<A>(with argument: A) -> Result<Void, AssertionFailure> where A: Equatable {
        return arguments.assertSize(of: 1)
            .flatMap { arguments[0].assertEqual(argument) }
    }

    /// Asserts that recorded call has expected arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, where these types are `Equatable`.
    /// - Returns: Assertion result.
    public func assertCalled<A, B>(with arguments: (A, B)) -> Result<Void, AssertionFailure>
        where A: Equatable, B: Equatable {
            return self.arguments.assertSize(of: 2)
                .flatMap { self.arguments[0].assertEqual(arguments.0) }
                .flatMap { self.arguments[1].assertEqual(arguments.1) }
    }

    /// Asserts that recorded call has expected arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, where these types are `Equatable`.
    /// - Returns: Assertion result.
    public func assertCalled<A, B, C>(with arguments: (A, B, C)) -> Result<Void, AssertionFailure>
        where A: Equatable, B: Equatable, C: Equatable {
            return self.arguments.assertSize(of: 3)
                .flatMap { self.arguments[0].assertEqual(arguments.0) }
                .flatMap { self.arguments[1].assertEqual(arguments.1) }
                .flatMap { self.arguments[2].assertEqual(arguments.2) }
    }

    /// Asserts that recorded call has expected arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, where these types are `Equatable`.
    /// - Returns: Assertion result.
    public func assertCalled<A, B, C, D>(with arguments: (A, B, C, D)) -> Result<Void, AssertionFailure>
        where A: Equatable, B: Equatable, C: Equatable, D: Equatable {
            return self.arguments.assertSize(of: 4)
                .flatMap { self.arguments[0].assertEqual(arguments.0) }
                .flatMap { self.arguments[1].assertEqual(arguments.1) }
                .flatMap { self.arguments[2].assertEqual(arguments.2) }
                .flatMap { self.arguments[3].assertEqual(arguments.3) }
    }

    /// Asserts that recorded call has expected arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, where these types are `Equatable`.
    /// - Returns: Assertion result.
    public func assertCalled<A, B, C, D, E>(with arguments: (A, B, C, D, E)) -> Result<Void, AssertionFailure>
        where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable {
            return self.arguments.assertSize(of: 5)
                .flatMap { self.arguments[0].assertEqual(arguments.0) }
                .flatMap { self.arguments[1].assertEqual(arguments.1) }
                .flatMap { self.arguments[2].assertEqual(arguments.2) }
                .flatMap { self.arguments[3].assertEqual(arguments.3) }
                .flatMap { self.arguments[4].assertEqual(arguments.4) }
    }

    /// Asserts that recorded call has expected arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, where these types are `Equatable`.
    /// - Returns: Assertion result.
    public func assertCalled<A, B, C, D, E, F>(with arguments: (A, B, C, D, E, F)) -> Result<Void, AssertionFailure>
        where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable, F: Equatable {
            return self.arguments.assertSize(of: 6)
                .flatMap { self.arguments[0].assertEqual(arguments.0) }
                .flatMap { self.arguments[1].assertEqual(arguments.1) }
                .flatMap { self.arguments[2].assertEqual(arguments.2) }
                .flatMap { self.arguments[3].assertEqual(arguments.3) }
                .flatMap { self.arguments[4].assertEqual(arguments.4) }
                .flatMap { self.arguments[5].assertEqual(arguments.5) }
    }

    /// Asserts that recorded call has expected arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, where these types are `Equatable`.
    /// - Returns: Assertion result.
    public func assertCalled<A, B, C, D, E, F, G>(with arguments: (A, B, C, D, E, F, G))
        -> Result<Void, AssertionFailure> where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable,
        F: Equatable, G: Equatable {
            return self.arguments.assertSize(of: 7)
                .flatMap { self.arguments[0].assertEqual(arguments.0) }
                .flatMap { self.arguments[1].assertEqual(arguments.1) }
                .flatMap { self.arguments[2].assertEqual(arguments.2) }
                .flatMap { self.arguments[3].assertEqual(arguments.3) }
                .flatMap { self.arguments[4].assertEqual(arguments.4) }
                .flatMap { self.arguments[5].assertEqual(arguments.5) }
                .flatMap { self.arguments[6].assertEqual(arguments.6) }
    }

    /// Asserts that recorded call has expected arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, where these types are `Equatable`.
    /// - Returns: Assertion result.
    public func assertCalled<A, B, C, D, E, F, G, H>(with arguments: (A, B, C, D, E, F, G, H))
        -> Result<Void, AssertionFailure> where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable,
        F: Equatable, G: Equatable, H: Equatable {
            return self.arguments.assertSize(of: 8)
                .flatMap { self.arguments[0].assertEqual(arguments.0) }
                .flatMap { self.arguments[1].assertEqual(arguments.1) }
                .flatMap { self.arguments[2].assertEqual(arguments.2) }
                .flatMap { self.arguments[3].assertEqual(arguments.3) }
                .flatMap { self.arguments[4].assertEqual(arguments.4) }
                .flatMap { self.arguments[5].assertEqual(arguments.5) }
                .flatMap { self.arguments[6].assertEqual(arguments.6) }
                .flatMap { self.arguments[7].assertEqual(arguments.7) }
    }

    /// Asserts that recorded call has expected arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, `I`, where these types are `Equatable`.
    /// - Returns: Assertion result.
    public func assertCalled<A, B, C, D, E, F, G, H, I>(with arguments: (A, B, C, D, E, F, G, H, I))
        -> Result<Void, AssertionFailure> where A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable,
        F: Equatable, G: Equatable, H: Equatable, I: Equatable {
            return self.arguments.assertSize(of: 9)
                .flatMap { self.arguments[0].assertEqual(arguments.0) }
                .flatMap { self.arguments[1].assertEqual(arguments.1) }
                .flatMap { self.arguments[2].assertEqual(arguments.2) }
                .flatMap { self.arguments[3].assertEqual(arguments.3) }
                .flatMap { self.arguments[4].assertEqual(arguments.4) }
                .flatMap { self.arguments[5].assertEqual(arguments.5) }
                .flatMap { self.arguments[6].assertEqual(arguments.6) }
                .flatMap { self.arguments[7].assertEqual(arguments.7) }
                .flatMap { self.arguments[8].assertEqual(arguments.8) }
    }
}

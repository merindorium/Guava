extension Array where Element == Argument {

    /// Asserts that arguments array is greater than or equal to expected size.
    /// - Parameters:
    ///   - expectedSize: Expected arguments array size.
    func assertSize(of expectedSize: Int) -> Result<Void, AssertionFailure> {
        guard count >= expectedSize else {
            let failure: AssertionFailure = .argumentsCountMismatch(
                expectedCount: expectedSize,
                providedCount: count
            )

            return .failure(failure)
        }

        return .success(())
    }

    /// Returns argument casted to specific type.
    ///
    /// - Note:
    ///
    ///     Raises fatal error if casting failed.
    ///
    /// - Parameters:
    ///   - firstType: Expected argument of type `A`.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    public func `as`<A>(_ type: A.Type,
                        file: StaticString = #file,
                        line: UInt = #line) -> A {
        if case .failure(let failure) = assertSize(of: 1) {
            FailureReporter.handler.handleFatalError(failure, location: .init(file: file, line: line))
        }

        return self[0].castStrictly(to: type, file: file, line: line)
    }

    /// Returns two arguments casted to specific types.
    ///
    /// - Note:
    ///
    ///     Raises fatal error if casting failed.
    ///
    /// - Parameters:
    ///   - firstType: Expected argument of type `A`.
    ///   - secondType: Expected argument of type `B`.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    public func `as`<A, B>(_ firstType: A.Type,
                           _ secondType: B.Type,
                           file: StaticString = #file,
                           line: UInt = #line) -> (A, B) {
        if case .failure(let failure) = assertSize(of: 2) {
            FailureReporter.handler.handleFatalError(failure, location: .init(file: file, line: line))
        }
        let first = self[0].castStrictly(to: firstType, file: file, line: line)
        let second = self[1].castStrictly(to: secondType, file: file, line: line)

        return (first, second)
    }

    /// Returns three arguments casted to specific types.
    ///
    /// - Note:
    ///
    ///     Raises fatal error if casting failed.
    ///
    /// - Parameters:
    ///   - firstType: Expected argument of type `A`.
    ///   - secondType: Expected argument of type `B`.
    ///   - thirdType: Expected argument of type `C`.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    public func `as`<A, B, C>(_ firstType: A.Type,
                              _ secondType: B.Type,
                              _ thirdType: C.Type,
                              file: StaticString = #file,
                              line: UInt = #line) -> (A, B, C) {
        if case .failure(let failure) = assertSize(of: 3) {
            FailureReporter.handler.handleFatalError(failure, location: .init(file: file, line: line))
        }
        let first = self[0].castStrictly(to: firstType, file: file, line: line)
        let second = self[1].castStrictly(to: secondType, file: file, line: line)
        let third = self[2].castStrictly(to: thirdType, file: file, line: line)

        return (first, second, third)
    }

    /// Returns four arguments casted to specific types.
    ///
    /// - Note:
    ///
    ///     Raises fatal error if casting failed.
    ///
    /// - Parameters:
    ///   - firstType: Expected argument of type `A`.
    ///   - secondType: Expected argument of type `B`.
    ///   - thirdType: Expected argument of type `C`.
    ///   - fourthType: Expected argument of type `D`.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    public func `as`<A, B, C, D>(_ firstType: A.Type,
                                 _ secondType: B.Type,
                                 _ thirdType: C.Type,
                                 _ fourthType: D.Type,
                                 file: StaticString = #file,
                                 line: UInt = #line) -> (A, B, C, D) {
        if case .failure(let failure) = assertSize(of: 4) {
            FailureReporter.handler.handleFatalError(failure, location: .init(file: file, line: line))
        }
        let first = self[0].castStrictly(to: firstType, file: file, line: line)
        let second = self[1].castStrictly(to: secondType, file: file, line: line)
        let third = self[2].castStrictly(to: thirdType, file: file, line: line)
        let fourth = self[3].castStrictly(to: fourthType, file: file, line: line)

        return (first, second, third, fourth)
    }

    /// Returns five arguments casted to specific types.
    ///
    /// - Note:
    ///
    ///     Raises fatal error if casting failed.
    ///
    /// - Parameters:
    ///   - firstType: Expected argument of type `A`.
    ///   - secondType: Expected argument of type `B`.
    ///   - thirdType: Expected argument of type `C`.
    ///   - fourthType: Expected argument of type `D`.
    ///   - fifthType: Expected argument of type `E`.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    public func `as`<A, B, C, D, E>(_ firstType: A.Type,
                                    _ secondType: B.Type,
                                    _ thirdType: C.Type,
                                    _ fourthType: D.Type,
                                    _ fifthType: E.Type,
                                    file: StaticString = #file,
                                    line: UInt = #line) -> (A, B, C, D, E) {
        if case .failure(let failure) = assertSize(of: 5) {
            FailureReporter.handler.handleFatalError(failure, location: .init(file: file, line: line))
        }
        let first = self[0].castStrictly(to: firstType, file: file, line: line)
        let second = self[1].castStrictly(to: secondType, file: file, line: line)
        let third = self[2].castStrictly(to: thirdType, file: file, line: line)
        let fourth = self[3].castStrictly(to: fourthType, file: file, line: line)
        let fifth = self[4].castStrictly(to: fifthType, file: file, line: line)

        return (first, second, third, fourth, fifth)
    }

    /// Returns six arguments casted to specific types.
    ///
    /// - Note:
    ///
    ///     Raises fatal error if casting failed.
    ///
    /// - Parameters:
    ///   - firstType: Expected argument of type `A`.
    ///   - secondType: Expected argument of type `B`.
    ///   - thirdType: Expected argument of type `C`.
    ///   - fourthType: Expected argument of type `D`.
    ///   - fifthType: Expected argument of type `E`.
    ///   - sixthType: Expected argument of type `F`.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    // swiftlint:disable function_parameter_count
    public func `as`<A, B, C, D, E, F>(_ firstType: A.Type,
                                       _ secondType: B.Type,
                                       _ thirdType: C.Type,
                                       _ fourthType: D.Type,
                                       _ fifthType: E.Type,
                                       _ sixthType: F.Type,
                                       file: StaticString = #file,
                                       line: UInt = #line) -> (A, B, C, D, E, F) {
        if case .failure(let failure) = assertSize(of: 6) {
            FailureReporter.handler.handleFatalError(failure, location: .init(file: file, line: line))
        }
        let first = self[0].castStrictly(to: firstType, file: file, line: line)
        let second = self[1].castStrictly(to: secondType, file: file, line: line)
        let third = self[2].castStrictly(to: thirdType, file: file, line: line)
        let fourth = self[3].castStrictly(to: fourthType, file: file, line: line)
        let fifth = self[4].castStrictly(to: fifthType, file: file, line: line)
        let sixth = self[5].castStrictly(to: sixthType, file: file, line: line)

        return (first, second, third, fourth, fifth, sixth)
    }

    /// Returns seven arguments casted to specific types.
    ///
    /// - Note:
    ///
    ///     Raises fatal error if casting failed.
    ///
    /// - Parameters:
    ///   - firstType: Expected argument of type `A`.
    ///   - secondType: Expected argument of type `B`.
    ///   - thirdType: Expected argument of type `C`.
    ///   - fourthType: Expected argument of type `D`.
    ///   - fifthType: Expected argument of type `E`.
    ///   - sixthType: Expected argument of type `F`.
    ///   - seventhType: Expected argument of type `G`.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    public func `as`<A, B, C, D, E, F, G>(_ firstType: A.Type,
                                          _ secondType: B.Type,
                                          _ thirdType: C.Type,
                                          _ fourthType: D.Type,
                                          _ fifthType: E.Type,
                                          _ sixthType: F.Type,
                                          _ seventhType: G.Type,
                                          file: StaticString = #file,
                                          line: UInt = #line) -> (A, B, C, D, E, F, G) {
        if case .failure(let failure) = assertSize(of: 7) {
            FailureReporter.handler.handleFatalError(failure, location: .init(file: file, line: line))
        }
        let first = self[0].castStrictly(to: firstType, file: file, line: line)
        let second = self[1].castStrictly(to: secondType, file: file, line: line)
        let third = self[2].castStrictly(to: thirdType, file: file, line: line)
        let fourth = self[3].castStrictly(to: fourthType, file: file, line: line)
        let fifth = self[4].castStrictly(to: fifthType, file: file, line: line)
        let sixth = self[5].castStrictly(to: sixthType, file: file, line: line)
        let seventh = self[6].castStrictly(to: seventhType, file: file, line: line)

        return (first, second, third, fourth, fifth, sixth, seventh)
    }

    /// Returns eight arguments casted to specific types.
    ///
    /// - Note:
    ///
    ///     Raises fatal error if casting failed.
    ///
    /// - Parameters:
    ///   - firstType: Expected argument of type `A`.
    ///   - secondType: Expected argument of type `B`.
    ///   - thirdType: Expected argument of type `C`.
    ///   - fourthType: Expected argument of type `D`.
    ///   - fifthType: Expected argument of type `E`.
    ///   - sixthType: Expected argument of type `F`.
    ///   - seventhType: Expected argument of type `G`.
    ///   - eighthType: Expected argument of type `H`.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    public func `as`<A, B, C, D, E, F, G, H>(_ firstType: A.Type,
                                             _ secondType: B.Type,
                                             _ thirdType: C.Type,
                                             _ fourthType: D.Type,
                                             _ fifthType: E.Type,
                                             _ sixthType: F.Type,
                                             _ seventhType: G.Type,
                                             _ eighthType: H.Type,
                                             file: StaticString = #file,
                                             line: UInt = #line) -> (A, B, C, D, E, F, G, H) {
        if case .failure(let failure) = assertSize(of: 8) {
            FailureReporter.handler.handleFatalError(failure, location: .init(file: file, line: line))
        }
        let first = self[0].castStrictly(to: firstType, file: file, line: line)
        let second = self[1].castStrictly(to: secondType, file: file, line: line)
        let third = self[2].castStrictly(to: thirdType, file: file, line: line)
        let fourth = self[3].castStrictly(to: fourthType, file: file, line: line)
        let fifth = self[4].castStrictly(to: fifthType, file: file, line: line)
        let sixth = self[5].castStrictly(to: sixthType, file: file, line: line)
        let seventh = self[6].castStrictly(to: seventhType, file: file, line: line)
        let eighth = self[7].castStrictly(to: eighthType, file: file, line: line)

        return (first, second, third, fourth, fifth, sixth, seventh, eighth)
    }

    /// Returns nine arguments casted to specific types.
    ///
    /// - Note:
    ///
    ///     Raises fatal error if casting failed.
    ///
    /// - Parameters:
    ///   - firstType: Expected argument of type `A`.
    ///   - secondType: Expected argument of type `B`.
    ///   - thirdType: Expected argument of type `C`.
    ///   - fourthType: Expected argument of type `D`.
    ///   - fifthType: Expected argument of type `E`.
    ///   - sixthType: Expected argument of type `F`.
    ///   - seventhType: Expected argument of type `G`.
    ///   - eighthType: Expected argument of type `H`.
    ///   - ninthType: Expected argument of type `I`.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    public func `as`<A, B, C, D, E, F, G, H, I>(_ firstType: A.Type,
                                                _ secondType: B.Type,
                                                _ thirdType: C.Type,
                                                _ fourthType: D.Type,
                                                _ fifthType: E.Type,
                                                _ sixthType: F.Type,
                                                _ seventhType: G.Type,
                                                _ eighthType: H.Type,
                                                _ ninthType: I.Type,
                                                file: StaticString = #file,
                                                line: UInt = #line) -> (A, B, C, D, E, F, G, H, I) {
        if case .failure(let failure) = assertSize(of: 9) {
            FailureReporter.handler.handleFatalError(failure, location: .init(file: file, line: line))
        }
        let first = self[0].castStrictly(to: firstType, file: file, line: line)
        let second = self[1].castStrictly(to: secondType, file: file, line: line)
        let third = self[2].castStrictly(to: thirdType, file: file, line: line)
        let fourth = self[3].castStrictly(to: fourthType, file: file, line: line)
        let fifth = self[4].castStrictly(to: fifthType, file: file, line: line)
        let sixth = self[5].castStrictly(to: sixthType, file: file, line: line)
        let seventh = self[6].castStrictly(to: seventhType, file: file, line: line)
        let eighth = self[7].castStrictly(to: eighthType, file: file, line: line)
        let ninth = self[8].castStrictly(to: ninthType, file: file, line: line)

        return (first, second, third, fourth, fifth, sixth, seventh, eighth, ninth)
    }
}

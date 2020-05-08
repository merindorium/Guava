extension Array where Element == Argument {

    /// Asserts that arguments array is greater than or equal to expected size.
    /// - Parameters:
    ///   - expectedSize: Expected arguments array size.
    ///   - strict: Indicates that failure should be handled as fatal error.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    @discardableResult
    func assertSize(of expectedSize: Int,
                    strict: Bool = false,
                    file: StaticString = #file,
                    line: UInt = #line) -> Bool {
        guard count >= expectedSize else {
            let failure: Failure = .argumentsCountMismatch(expectedCount: expectedSize,
                                                           providedCount: count)

            if strict {
                FailureReporter.handler.handleFatalError(failure,
                                                         location: ReportLocation(file: file, line: line))
            } else {
                FailureReporter.handler.handleFailure(failure,
                                                      location: ReportLocation(file: file, line: line))
            }

            return false
        }

        return true
    }
}

extension Array where Element == Argument {

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
        assertSize(of: 1, strict: true, file: file, line: line)
        let first = self[0].castStrictly(to: type, argumentPosition: .first)

        return (first)
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
        assertSize(of: 2, strict: true, file: file, line: line)

        let first = self[0].castStrictly(to: firstType, argumentPosition: .first)
        let second = self[1].castStrictly(to: secondType, argumentPosition: .second)

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
        assertSize(of: 3, strict: true, file: file, line: line)

        let first = self[0].castStrictly(to: firstType, argumentPosition: .first)
        let second = self[1].castStrictly(to: secondType, argumentPosition: .second)
        let third = self[2].castStrictly(to: thirdType, argumentPosition: .third)

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
        assertSize(of: 4, strict: true, file: file, line: line)

        let first = self[0].castStrictly(to: firstType, argumentPosition: .first)
        let second = self[1].castStrictly(to: secondType, argumentPosition: .second)
        let third = self[2].castStrictly(to: thirdType, argumentPosition: .third)
        let fourth = self[3].castStrictly(to: fourthType, argumentPosition: .fourth)

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
        assertSize(of: 5, strict: true, file: file, line: line)

        let first = self[0].castStrictly(to: firstType, argumentPosition: .first)
        let second = self[1].castStrictly(to: secondType, argumentPosition: .second)
        let third = self[2].castStrictly(to: thirdType, argumentPosition: .third)
        let fourth = self[3].castStrictly(to: fourthType, argumentPosition: .fourth)
        let fifth = self[4].castStrictly(to: fifthType, argumentPosition: .fifth)

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
        assertSize(of: 6, strict: true, file: file, line: line)

        let first = self[0].castStrictly(to: firstType, argumentPosition: .first)
        let second = self[1].castStrictly(to: secondType, argumentPosition: .second)
        let third = self[2].castStrictly(to: thirdType, argumentPosition: .third)
        let fourth = self[3].castStrictly(to: fourthType, argumentPosition: .fourth)
        let fifth = self[4].castStrictly(to: fifthType, argumentPosition: .fifth)
        let sixth = self[5].castStrictly(to: sixthType, argumentPosition: .sixth)

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
        assertSize(of: 7, strict: true, file: file, line: line)

        let first = self[0].castStrictly(to: firstType, argumentPosition: .first)
        let second = self[1].castStrictly(to: secondType, argumentPosition: .second)
        let third = self[2].castStrictly(to: thirdType, argumentPosition: .third)
        let fourth = self[3].castStrictly(to: fourthType, argumentPosition: .fourth)
        let fifth = self[4].castStrictly(to: fifthType, argumentPosition: .fifth)
        let sixth = self[5].castStrictly(to: sixthType, argumentPosition: .sixth)
        let seventh = self[6].castStrictly(to: seventhType, argumentPosition: .seventh)

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
        assertSize(of: 8, strict: true, file: file, line: line)

        let first = self[0].castStrictly(to: firstType, argumentPosition: .first)
        let second = self[1].castStrictly(to: secondType, argumentPosition: .second)
        let third = self[2].castStrictly(to: thirdType, argumentPosition: .third)
        let fourth = self[3].castStrictly(to: fourthType, argumentPosition: .fourth)
        let fifth = self[4].castStrictly(to: fifthType, argumentPosition: .fifth)
        let sixth = self[5].castStrictly(to: sixthType, argumentPosition: .sixth)
        let seventh = self[6].castStrictly(to: seventhType, argumentPosition: .seventh)
        let eighth = self[7].castStrictly(to: eighthType, argumentPosition: .eighth)

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
        assertSize(of: 9, strict: true, file: file, line: line)

        let first = self[0].castStrictly(to: firstType, argumentPosition: .first)
        let second = self[1].castStrictly(to: secondType, argumentPosition: .second)
        let third = self[2].castStrictly(to: thirdType, argumentPosition: .third)
        let fourth = self[3].castStrictly(to: fourthType, argumentPosition: .fourth)
        let fifth = self[4].castStrictly(to: fifthType, argumentPosition: .fifth)
        let sixth = self[5].castStrictly(to: sixthType, argumentPosition: .sixth)
        let seventh = self[6].castStrictly(to: seventhType, argumentPosition: .seventh)
        let eighth = self[7].castStrictly(to: eighthType, argumentPosition: .eighth)
        let ninth = self[8].castStrictly(to: ninthType, argumentPosition: .ninth)

        return (first, second, third, fourth, fifth, sixth, seventh, eighth, ninth)
    }
}

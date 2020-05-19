/// Represents expected method call.
public struct MethodCall {

    /// Closure that stores assertion logic.
    private let assertionClosure: (RecordedMethodCall) -> Result<Void, Failure>

    /// Asserts that expected method call is equal to recorded one.
    /// - Parameter methodCall: Recorded method call.
    /// - Returns: Assertion result.
    public func assertEquals(to methodCall: RecordedMethodCall) -> Result<Void, Failure> {
        return assertionClosure(methodCall)
    }
}

extension MethodCall {

    /// Instantiates `MethodCall` with given argument.
    /// - Parameter argument: An argument of type `A`, where `A` is `Equatable`.
    public init<A>(argument: A) where A: Equatable {
        assertionClosure = {
            return $0.assertCalled(with: argument)
        }
    }

    /// Instantiates `MethodCall` with given arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, where these types are `Equatable`.
    public init<A, B>(arguments: (A, B)) where A: Equatable, B: Equatable {
        assertionClosure = {
            return $0.assertCalled(with: arguments)
        }
    }

    /// Instantiates `MethodCall` with given arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, where these types are `Equatable`.
    public init<A, B, C>(arguments: (A, B, C)) where A: Equatable, B: Equatable, C: Equatable {
        assertionClosure = {
            return $0.assertCalled(with: arguments)
        }
    }

    /// Instantiates `MethodCall` with given arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, where these types are `Equatable`.
    public init<A, B, C, D>(arguments: (A, B, C, D)) where A: Equatable, B: Equatable, C: Equatable, D: Equatable {
        assertionClosure = {
            return $0.assertCalled(with: arguments)
        }
    }

    /// Instantiates `MethodCall` with given arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, where these types are `Equatable`.
    public init<A, B, C, D, E>(arguments: (A, B, C, D, E)) where A: Equatable, B: Equatable, C: Equatable,
        D: Equatable, E: Equatable {
            assertionClosure = {
                return $0.assertCalled(with: arguments)
            }
    }

    /// Instantiates `MethodCall` with given arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, where these types are `Equatable`.
    public init<A, B, C, D, E, F>(arguments: (A, B, C, D, E, F)) where A: Equatable, B: Equatable, C: Equatable,
        D: Equatable, E: Equatable, F: Equatable {
            assertionClosure = {
                return $0.assertCalled(with: arguments)
            }
    }

    /// Instantiates `MethodCall` with given arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G` where these types are `Equatable`.
    public init<A, B, C, D, E, F, G>(arguments: (A, B, C, D, E, F, G)) where A: Equatable, B: Equatable,
        C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable {
            assertionClosure = {
                return $0.assertCalled(with: arguments)
            }
    }

    /// Instantiates `MethodCall` with given arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, where these types are `Equatable`.
    public init<A, B, C, D, E, F, G, H>(arguments: (A, B, C, D, E, F, G, H)) where A: Equatable, B: Equatable,
        C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable, H: Equatable {
            assertionClosure = {
                return $0.assertCalled(with: arguments)
            }
    }

    /// Instantiates `MethodCall` with given arguments.
    /// - Parameter arguments: A tuple of types `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, `I`, where these types are `Equatable`.
    public init<A, B, C, D, E, F, G, H, I>(arguments: (A, B, C, D, E, F, G, H, I)) where A: Equatable, B: Equatable,
        C: Equatable, D: Equatable, E: Equatable, F: Equatable, G: Equatable, H: Equatable, I: Equatable {
            assertionClosure = {
                return $0.assertCalled(with: arguments)
            }
    }
}

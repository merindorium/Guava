@available(iOS 13, macOS 10.15, *)
enum AsyncClosure<Value>: Sendable {

    case normal(@Sendable ([Argument]) async -> Value)
    case throwing(@Sendable ([Argument]) async throws -> Value)
}

@available(iOS 13, macOS 10.15, *)
extension AsyncClosure: CustomStringConvertible {

    var description: String {
        switch self {
        case .normal:
            return "Normal"
        case .throwing:
            return "Throwing"
        }
    }
}

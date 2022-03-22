enum Closure<Value> {

    case normal(([Argument]) -> Value)
    case throwing(([Argument]) throws -> Value)
    case async(([Argument]) async -> Value)
    case asyncThrowing(([Argument]) async throws -> Value)
}

extension Closure: CustomStringConvertible {

    var description: String {
        switch self {
        case .normal:
            return "Normal"
        case .throwing:
            return "Throwing"
        case .async:
            return "Async"
        case .asyncThrowing:
            return "AsyncThrowing"
        }
    }
}

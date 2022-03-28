enum Closure<Value> {

    case normal(([Argument]) -> Value)
    case throwing(([Argument]) throws -> Value)
}

extension Closure: CustomStringConvertible {

    var description: String {
        switch self {
        case .normal:
            return "Normal"
        case .throwing:
            return "Throwing"
        }
    }
}

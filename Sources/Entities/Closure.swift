enum Closure<Value> {

    case normal(([Argument]) -> Value)
    case throwing(([Argument]) throws -> Value)
}

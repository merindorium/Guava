/// A `Stub` provides hardcoded answers to calls made during the test.
final class Stub<Value> {

    private var stubbedValue: Value

    init(stubbedValue: Value) {
        self.stubbedValue = stubbedValue
    }
}

extension Stub: Invokable {

    func invoke(arguments: [Any]) -> Value {
        return stubbedValue
    }
}

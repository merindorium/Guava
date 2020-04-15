import Guava

protocol Multiplier {

    func multiply(_ a: Int, _ b: Int) -> Int
}

struct Calculator {

    private let multiplier: Multiplier

    init(multiplier: Multiplier) {
        self.multiplier = multiplier
    }

    func multiply(_ a: Int, _ b: Int) -> Int {
        return multiplier.multiply(a, b)
    }
}

class MultiplierTestDouble: Multiplier {

    var multiplyMethod = TestDoubleFactory<Int>()

    func multiply(_ a: Int, _ b: Int) -> Int {
        return multiplyMethod.invoke(arguments: [a, b])
    }
}

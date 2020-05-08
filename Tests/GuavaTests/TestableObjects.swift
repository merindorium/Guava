import Guava

protocol Multiplier {

    func multiply(_ left: Int, _ right: Int) -> Int
}

struct Calculator {

    private let multiplier: Multiplier

    init(multiplier: Multiplier) {
        self.multiplier = multiplier
    }

    func multiply(_ left: Int, _ right: Int) -> Int {
        return multiplier.multiply(left, right)
    }
}

class MultiplierTestDouble: Multiplier {

    var multiplyMethod = TestDoubleFactory<Int>()

    func multiply(_ left: Int, _ right: Int) -> Int {
        return multiplyMethod.invoke(arguments: [left, right])
    }
}

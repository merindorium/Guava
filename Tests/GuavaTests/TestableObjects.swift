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

protocol ThrowingMultiplier {

    func multiply(_ lhs: Int, _ rhs: Int) throws -> Int
}

struct ThrowingCalculator {

    private let multiplier: ThrowingMultiplier

    init(multiplier: ThrowingMultiplier) {
        self.multiplier = multiplier
    }

    func multiply(_ lhs: Int, _ rhs: Int) throws -> Int {
        return try multiplier.multiply(lhs, rhs)
    }
}

class ThrowingMultiplierTestDouble: ThrowingMultiplier {

    let multiplyMethod = ThrowingTestDoubleFactory<Int>()

    func multiply(_ lhs: Int, _ rhs: Int) throws -> Int {
        try multiplyMethod.throwingInvoke(arguments: [lhs, rhs])
    }
}

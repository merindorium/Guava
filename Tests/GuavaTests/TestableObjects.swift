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

@available(iOS 13, macOS 10.15, *)
protocol AsyncMultiplier {

    func multiply(_ left: Int, _ right: Int) async -> Int
}

@available(iOS 13, macOS 10.15, *)
struct AsyncCalculator {

    private let multiplier: AsyncMultiplier

    init(multiplier: AsyncMultiplier) {
        self.multiplier = multiplier
    }

    func multiply(_ left: Int, _ right: Int) async -> Int {
        return await multiplier.multiply(left, right)
    }
}

@available(iOS 13, macOS 10.15, *)
class AsyncMultiplierTestDouble: AsyncMultiplier {

    var multiplyMethod = AsyncTestDoubleFactory<Int>()

    func multiply(_ left: Int, _ right: Int) async -> Int {
        return await multiplyMethod.asyncInvoke(arguments: [left, right])
    }
}

@available(iOS 13, macOS 10.15, *)
protocol ThrowingAsyncMultiplier {

    func multiply(_ left: Int, _ right: Int) async throws -> Int
}

@available(iOS 13, macOS 10.15, *)
struct ThrowingAsyncCalculator {

    private let multiplier: ThrowingAsyncMultiplier

    init(multiplier: ThrowingAsyncMultiplier) {
        self.multiplier = multiplier
    }

    func multiply(_ left: Int, _ right: Int) async throws -> Int {
        return try await multiplier.multiply(left, right)
    }
}

@available(iOS 13, macOS 10.15, *)
class ThrowingAsyncMultiplierTestDouble: ThrowingAsyncMultiplier {

    var multiplyMethod = ThrowingAsyncTestDoubleFactory<Int>()

    func multiply(_ left: Int, _ right: Int) async throws -> Int {
        return try await multiplyMethod.throwingAsyncInvoke(arguments: [left, right])
    }
}

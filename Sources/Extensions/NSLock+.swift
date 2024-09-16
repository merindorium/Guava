#if os(Linux)
import Foundation

extension NSLock {

    func withLock<R>(_ body: () throws -> R) rethrows -> R {
        lock()
        defer { unlock() }
        return try body()
    }
}
#endif

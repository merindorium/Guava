import Foundation

extension NSError {

    static var testableError: NSError {
        return NSError(domain: "guava.tests", code: .zero)
    }
}

import XCTest

import ExampleTests
import GuavaTests

var tests = [XCTestCaseEntry]()
tests += GuavaTests.allTests()
tests += ExampleTests.allTests()
XCTMain(tests)

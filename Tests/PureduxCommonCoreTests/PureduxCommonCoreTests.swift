import XCTest
@testable import PureduxCommonCore

final class PureduxCommonCoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PureduxCommonCore().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

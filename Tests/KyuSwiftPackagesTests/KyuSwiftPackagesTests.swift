import XCTest
@testable import KyuGenericExtensions
@testable import KyuNetworkExtensions

final class KyuSwiftPackagesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(KyuSwiftPackages().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

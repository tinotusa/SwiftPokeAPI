import XCTest
@testable import SwiftPokeAPI

final class SwiftPokeAPITests: XCTestCase {
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let language = try! await Language("en")
        print("*******The language is*******")
        print(language)
        print("**************")
        XCTAssertNotNil(language)
        XCTAssertEqual(SwiftPokeAPI().text, "Hello, World!")
    }
}

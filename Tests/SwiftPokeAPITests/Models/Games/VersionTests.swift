//
//  VersionTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class VersionTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "red"
        do {
            let version = try await Version(name)
            XCTAssertEqual(version.name, name)
        } catch {
            XCTFail("Error with version named: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "magenta"
        do {
            let _ = try await Version(name)
            XCTFail("Error with version named: \(name). This isn't supposed to happen. Test is suppsed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Error with version named: \(name). \(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 39 {
                group.addTask {
                    do {
                        let version = try await Version("\(id)")
                        XCTAssertEqual(version.id, id)
                    } catch {
                        XCTFail("Error with version id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

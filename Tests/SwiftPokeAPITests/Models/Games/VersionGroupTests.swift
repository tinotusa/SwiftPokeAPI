//
//  VersionGroupTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class VersionGroupTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "red-blue"
        do {
            let versionGroup = try await VersionGroup(name)
            XCTAssertEqual(versionGroup.name, name)
        } catch {
            XCTFail("Error with version group named: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "magenta-purple"
        do {
            let _ = try await VersionGroup(name)
            XCTFail("Error with version group named: \(name). This isn't supposed to happen. Test is suppsed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Error with version group named: \(name). \(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 24 {
                group.addTask {
                    do {
                        let versionGroup = try await VersionGroup("\(id)")
                        XCTAssertEqual(versionGroup.id, id)
                    } catch {
                        XCTFail("Error with version group id: \(id).\n\(error)")
                    }
                }
            }
        }
    }

}

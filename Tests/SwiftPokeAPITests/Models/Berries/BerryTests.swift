//
//  BerryTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class BerryTests: XCTestCase {
    private var pokeAPI: PokeAPI!

    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async throws {
        do {
            let name = "cheri"
            let berry = try await Berry(name)
            XCTAssertEqual(berry.name, name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInitWithInvalidName() async throws {
        do {
            let name = "notAThing"
            let _ = try await Berry(name)
            XCTFail("This shouldn't happen.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        }
    }
    
    func testInitWithValidIDS() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 64 {
                group.addTask {
                    do {
                        let _ = try await Berry("\(id)")
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                }
            }
        }
        XCTAssertTrue(true)
    }
}

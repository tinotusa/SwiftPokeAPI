//
//  MoveBattleStyleTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class MoveBattleStyleTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "attack"
        do {
            let moveBattleStyle = try await MoveBattleStyle(name)
            XCTAssertEqual(moveBattleStyle.name, name)
        } catch {
            XCTFail("Failed to get MoveBattleStyle with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "invalidMoveBattleStyle"
        do {
            let _ = try await MoveBattleStyle(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get MoveBattleStyle with id: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 3 {
                group.addTask {
                    do {
                        let moveBattleStyle = try await MoveBattleStyle("\(id)")
                        XCTAssertEqual(moveBattleStyle.id, id)
                    } catch {
                        XCTFail("Failed to get MoveBattleStyle with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}


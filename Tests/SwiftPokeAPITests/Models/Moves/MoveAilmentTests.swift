//
//  MoveAilmentTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class MoveAilmentTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "paralysis"
        do {
            let moveAilment = try await MoveAilment(name)
            XCTAssertEqual(moveAilment.name, name)
        } catch {
            XCTFail("Failed to get MoveAilment with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "invalidMoveAilmentName"
        do {
            let _ = try await MoveAilment(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get MoveAilment with id: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        let invalidIDs = [
            33, 38, 39, 34, 40, 30, 37, 31, 41, 32, 25, 36, 27,
            10, 16, 11, 23, 28, 29, 35, 26, 22
        ]
        await withTaskGroup(of: Void.self) { group in
            for id in -1 ... 42 where !invalidIDs.contains(id) {
                group.addTask {
                    do {
                        let moveAilment = try await MoveAilment("\(id)")
                        XCTAssertEqual(moveAilment.id, id)
                    } catch {
                        XCTFail("Failed to get MoveAilment with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

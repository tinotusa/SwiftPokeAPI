//
//  AbilityTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class AbilityTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testInitWithValidName() async {
        let name = "stench"
        do {
            let ability = try await Ability(name)
            XCTAssertEqual(ability.name, name)
        } catch {
            XCTFail("Failed to get Ability with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "notAnAbility"
        do {
            let _ = try await Ability(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTAssertTrue(true)
        }
    }
    
    func testInitWithValidIDs() async {
        let invalidIDs = [
            272, 273, 268, 269, 271, 280, 275, 274, 282, 278, 281, 276, 285, 283, 292, 290,
            289, 284, 293, 286, 279, 298, 288, 270, 301, 297, 295, 303, 299, 291, 287, 302,
            306, 304, 312, 314, 300, 310, 296, 309, 313, 294, 308, 319, 277, 307, 316, 311,
            323, 325, 324, 321, 322, 327, 326, 318, 320, 305, 317, 315
        ]
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 327 where !invalidIDs.contains(id) {
                group.addTask {
                    do {
                        let ability = try await Ability("\(id)")
                        XCTAssertEqual(ability.id, id)
                    } catch {
                        XCTFail("Failed to get Ability with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

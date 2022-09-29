//
//  EncounterConditionTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class EncounterConditionTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitWithValidName() async {
        let name = "swarm"
        do {
            let encounterCondition = try await EncounterCondition(name)
            XCTAssertEqual(encounterCondition.name, name)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "notAThing"
        do {
            let _ = try await EncounterCondition(name)
            XCTFail("This this shouldn't happen.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testInitWithValidIDS() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 13 {
                group.addTask {
                    do {
                        let encounterCondition = try await EncounterCondition("\(id)")
                        XCTAssertEqual(encounterCondition.id, id)
                    } catch {
                        XCTFail("\(error)")
                    }
                }
            }
        }
    }
}

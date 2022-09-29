//
//  EvolutionTriggerTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class EvolutionTriggerTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "level-up"
        do {
            let evolutionTrigger = try await EvolutionTrigger(name)
            XCTAssertEqual(evolutionTrigger.name, name)
        } catch {
            XCTFail("Error with name: \(name).\n\(error)")
        }
    }

    func testInitWithInvalidName() async {
        let name = "notreal"
        do {
            let _ = try await EvolutionTrigger(name)
            XCTFail("This shouldn't happen.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 10 {
                group.addTask {
                    do {
                        let evolutionTrigger = try await EvolutionTrigger("\(id)")
                        XCTAssertEqual(evolutionTrigger.id, id)
                    } catch {
                        XCTFail("Error with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

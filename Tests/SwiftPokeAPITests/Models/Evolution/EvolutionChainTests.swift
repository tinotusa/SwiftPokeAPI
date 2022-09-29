//
//  EvolutionChainTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class EvolutionChainTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidID() async {
        let id = 7
        do {
            let evolutionChain = try await EvolutionChain(id)
            XCTAssertEqual(evolutionChain.id, id)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testWithInitWithInvalidID() async {
        let id = 0
        do {
            let _ = try await EvolutionChain(id)
            XCTFail("This shouldn't happen.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        // apparently these ids aren't in the database
        let invalidIDs = [225, 226, 222, 210, 227, 238, 231, 251]
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 468 where !invalidIDs.contains(id) {
                group.addTask {
                    do {
                        let evolutionChain = try await EvolutionChain(id)
                        XCTAssertEqual(evolutionChain.id, id)
                    } catch {
                        XCTFail("\(error) id: \(id)")
                    }
                }
            }
        }
    }
}

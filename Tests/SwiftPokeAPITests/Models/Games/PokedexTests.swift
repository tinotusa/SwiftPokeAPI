//
//  PokedexTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class PokedexTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "kanto"
        do {
            let pokedex = try await Pokedex(name)
            XCTAssertEqual(pokedex.name, name)
        } catch {
            XCTFail("Error with pokedex named: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "hyrule"
        do {
            let _ = try await Pokedex(name)
            XCTFail("Error with pokedex named: \(name). This isn't supposed to happen. Test is suppsed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Error with pokedex named: \(name). \(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            // 10 isn't in the pokeapi database
            for id in 1 ... 29 where id != 10 {
                group.addTask {
                    do {
                        let pokedex = try await Pokedex("\(id)")
                        XCTAssertEqual(pokedex.id, id)
                    } catch {
                        XCTFail("Error with pokedex id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

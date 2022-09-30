//
//  PokemonTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class PokemonTests: XCTestCase {
    func testInitWithName() async {
        let name = "clefairy"
        do {
            let pokemon = try await Pokemon(name)
            XCTAssertEqual(pokemon.name, name)
        } catch {
            XCTFail("Failed to get Pokemon with name: \(name).\n\(error)")
        }
    }

    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 905 {
                group.addTask {
                    do {
                        let pokemon = try await Pokemon("\(id)")
                        XCTAssertEqual(pokemon.id, id)
                    } catch {
                        XCTFail("Failed to get Pokemon with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

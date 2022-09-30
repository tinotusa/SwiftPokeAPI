//
//  PokemonSpeciesTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class PokemonSpeciesTests: XCTestCase {
    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 905 {
                group.addTask {
                    do {
                        let pokemonSpecies = try await PokemonSpecies("\(id)")
                        XCTAssertEqual(pokemonSpecies.id, id)
                    } catch {
                        XCTFail("Failed to get PokemonSpecies with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

//
//  PokemonHabitatTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class PokemonHabitatTests: XCTestCase {
    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 9 {
                group.addTask {
                    do {
                        let pokemonHabitat = try await PokemonHabitat("\(id)")
                        XCTAssertEqual(pokemonHabitat.id, id)
                    } catch {
                        XCTFail("Failed to get PokemonHabitat with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

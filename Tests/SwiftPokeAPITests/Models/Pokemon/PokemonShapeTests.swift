//
//  PokemonShapeTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI
final class PokemonShapeTests: XCTestCase {
    func testIniWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 14 {
                group.addTask {
                    do {
                        let pokemonShape = try await PokemonShape("\(id)")
                        XCTAssertEqual(pokemonShape.id, id)
                    } catch {
                        XCTFail("Failed to get PokemonShape with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

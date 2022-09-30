//
//  PokemonFormTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class PokemonFormTests: XCTestCase {
    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 905 {
                group.addTask {
                    do {
                        let pokemonForm = try await PokemonForm("\(id)")
                        XCTAssertEqual(pokemonForm.id, id)
                    } catch {
                        XCTFail("Failed to get PokemonForm with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

//
//  PokemonColorTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class PokemonColorTests: XCTestCase {
    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 10 {
                group.addTask {
                    do {
                        let pokemonColor = try await PokemonColor("\(id)")
                        XCTAssertEqual(pokemonColor.id, id)
                    } catch {
                        XCTFail("Failed to get pokemon color with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

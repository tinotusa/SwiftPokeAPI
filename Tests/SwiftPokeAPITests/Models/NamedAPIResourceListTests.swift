//
//  NamedAPIResourceListTests.swift
//  
//
//  Created by Tino on 2/10/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class NamedAPIResourceListTests: XCTestCase {
    func testFetchResource() async throws {
        do {
            let limit = 20
            let pokemonList = try await NamedAPIResourceList(.pokemon, limit: limit)
            XCTAssertEqual(pokemonList.results.count, limit)
        } catch {
            XCTFail("Failed to get resource list. \(error)")
        }
    }

    func testFetchResourceStress() async {
        let resources: [PokeAPIEndpoint] = [.pokemon, .type, .abilities, .berry, .characteristic]
        let limit = 20
        let offset = 0
        await withTaskGroup(of: Void.self) { group in
            for resource in resources {
                group.addTask {
                    do {
                        let resourceList = try await NamedAPIResourceList(resource, limit: limit, offset: offset)
                        XCTAssertTrue(resourceList.results.count <= limit)
                    } catch {
                        XCTFail("Failed to get resource list for endpoint: \(resource). \(error)")
                    }
                }
            }
        }
    }
    
    func testInitWithInvalidLimit() async {
        do {
            let limit = -20
            let pokemonList = try await NamedAPIResourceList(.pokemon, limit: limit)
            XCTAssertEqual(pokemonList.results.count, limit)
        } catch NamedAPIResourceList.NamedAPIResourceListError.invalidLimit(let limit) {
            XCTAssertTrue(true, "Failed to create resource list if invalid limit: \(limit).")
        } catch {
            XCTFail("Failed to get resource list. \(error)")
        }
    }
    
    func testInitWithValidURL() async {
        do {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=20")!
            let pokemonList = try await NamedAPIResourceList(url)
            XCTAssertEqual(pokemonList.results.count, 20)
        } catch NamedAPIResourceList.NamedAPIResourceListError.invalidLimit(let limit) {
            XCTAssertTrue(true, "Failed to create resource list if invalid limit: \(limit).")
        } catch {
            XCTFail("Failed to get resource list. \(error)")
        }
    }

}

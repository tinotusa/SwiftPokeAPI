//
//  PalParkArea.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct PalParkArea: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of Pokémon encountered in thi pal park area along with details.
    public let pokemonEncounters: [PalParkEncounterSpecies]
}

public extension PalParkArea {
    /// Fetches a PalParkArea from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name or id of the PalParkArea.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .palParkArea, name: name)
    }
}

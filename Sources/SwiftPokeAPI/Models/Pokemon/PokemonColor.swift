//
//  PokemonColor.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonColor: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of the Pokémon species that have this color.
    public let pokemonSpecies: [NamedAPIResource]
}

public extension PokemonColor {
    /// Fetches a PokemonColor from pokeapi.
    /// - parameter name: The name or id of the PokemonColor.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .pokemonColor, name: name)
    }
}

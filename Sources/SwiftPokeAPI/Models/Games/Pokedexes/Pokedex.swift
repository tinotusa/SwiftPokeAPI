//
//  Pokedex.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Pokedex: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// Whether or not this Pokédex originated in the main series of the video games.
    public let isMainSeries: Bool
    /// The description of this resource listed in different languages.
    public let descriptions: [Description]
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of Pokémon catalogued in this Pokédex and their indexes.
    public let pokemonEntries: [PokemonEntry]
    /// The region this Pokédex catalogues Pokémon for.
    public let region: NamedAPIResource?
    /// A list of version groups this Pokédex is relevant to.
    public let versionGroups: [NamedAPIResource]
}

public extension Pokedex {
    /// Fetches a Pokedex from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name or id of the pokedex.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .pokedex, name: name)
    }
}
//
//  Pokedex.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Pokedex: Codable, Identifiable, Hashable {
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
    /// - parameter name: The name of the pokedex.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .pokedex, name: name)
    }
    
    /// Fetches a Pokedex from pokeapi.
    /// - parameter id: The id of the Pokedex.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Pokedex from pokeapi.
    /// - parameter url: The url of the Pokedex.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension Pokedex: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .pokedex
    }
}

//
//  Generation.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Generation: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of abilities that were introduced in this generation.
    public let abilities: [NamedAPIResource]
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// The main region travelled in this generation.
    public let mainRegion:  NamedAPIResource
    /// A list of moves that were introduced in this generation.
    public let moves: [NamedAPIResource]
    /// A list of Pokémon species that were introduced in this generation.
    public let pokemonSpecies: [NamedAPIResource]
    /// A list of types that were introduced in this generation.
    public let types: [NamedAPIResource]
    /// A list of version groups that were introduced in this generation.
    public let versionGroups: [NamedAPIResource]
}

public extension Generation {
    /// Fetches a Generation from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name of the Generation.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .generation, name: name)
    }
    
    /// Fetches a Generation from pokeapi.
    /// - parameter id: The id of the Generation.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Generation from pokeapi.
    /// - parameter url: The url of the Generation.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

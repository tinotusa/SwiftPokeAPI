//
//  Gender.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct Gender: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of Pokémon species that can be this gender and how likely it is that they will be.
    public let pokemonSpeciesDetails: [PokemonSpeciesGender]
    /// A list of Pokémon species that required this gender in order for a Pokémon to evolve into them.
    public let requiredForEvolution: [NamedAPIResource]
}

public extension Gender {
    /// Fetches a Gender from pokeapi.
    /// - parameter name: The name of the Gender.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .gender, name: name)
    }
    
    /// Fetches a Gender from pokeapi.
    /// - parameter id: The id of the Gender.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Gender from pokeapi.
    /// - parameter url: The url of the Gender.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension Gender: SearchableByURL { }

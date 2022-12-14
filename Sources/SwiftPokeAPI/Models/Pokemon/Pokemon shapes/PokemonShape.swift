//
//  PokemonShape.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonShape: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The "scientific" name of this Pokémon shape listed in different languages.
    public let awesomeNames: [AwesomeName]
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of the Pokémon species that have this shape.
    public let pokemonSpecies: [NamedAPIResource]
}

public extension PokemonShape {
    /// Fetches a PokemonShape from pokeapi.
    /// - parameter name: The name of a PokemonShape.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .pokemonShape, name: name)
    }
    
    /// Fetches a PokemonShape from pokeapi.
    /// - parameter id: The id of the PokemonShape.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a PokemonShape from pokeapi.
    /// - parameter url: The url of the PokemonShape.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension PokemonShape: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .pokemonShape
    }
}

extension PokemonShape: Comparable {
    public static func < (lhs: PokemonShape, rhs: PokemonShape) -> Bool {
        lhs.id < rhs.id
    }
}

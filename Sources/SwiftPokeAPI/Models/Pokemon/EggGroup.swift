//
//  EggGroup.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct EggGroup: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of all Pokémon species that are members of this egg group.
    public let pokemonSpecies: [NamedAPIResource]
}

public extension EggGroup {
    /// Fetches an EggGroup from pokeapi.
    /// - parameter name: The name of the EggGroup.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .eggGroup, name: name)
    }
    
    /// Fetches an EggGroup from pokeapi.
    /// - parameter id: The id of the EggGroup.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches an EggGroup from pokeapi.
    /// - parameter url: The url of the EggGroup.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension EggGroup: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .eggGroup
    }
}

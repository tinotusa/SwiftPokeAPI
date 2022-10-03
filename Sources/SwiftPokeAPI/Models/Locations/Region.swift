//
//  Region.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Region: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// A list of locations that can be found in this region.
    public let locations: [NamedAPIResource]
    /// The name for this resource.
    public let name: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// The generation this region was introduced in.
    public let mainGeneration: NamedAPIResource?
    /// A list of pokédexes that catalogue Pokémon in this region.
    public let pokedexes: [NamedAPIResource]
    /// A list of version groups where this region can be visited.
    public let versionGroups: [NamedAPIResource]
}

public extension Region {
    /// Fetches a Region from pokeapi.
    /// - parameter name: The name or id of the Region.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .region, name: name)
    }
}
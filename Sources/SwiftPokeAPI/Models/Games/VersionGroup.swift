//
//  VersionGroup.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct VersionGroup: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// Order for sorting. Almost by date of release, except similar versions are grouped together.
    public let order: Int
    /// The generation this version was introduced in.
    public let generation: NamedAPIResource
    /// A list of methods in which Pokémon can learn moves in this version group.
    public let moveLearnMethods: [NamedAPIResource]
    /// A list of Pokédexes introduces in this version group.
    public let pokedexes: [NamedAPIResource]
    /// A list of regions that can be visited in this version group.
    public let regions: [NamedAPIResource]
    /// The versions this version group owns.
    public let versions: [NamedAPIResource]
}

public extension VersionGroup {
    /// Fetches a VersionGroup from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name or id of the VersionGroup.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .versionGroup, name: name)
    }
}

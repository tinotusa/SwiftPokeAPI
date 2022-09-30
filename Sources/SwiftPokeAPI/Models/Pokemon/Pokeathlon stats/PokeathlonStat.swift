//
//  PokeathlonStat.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokeathlonStat: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A detail of natures which affect this Pokéathlon stat positively or negatively.
    public let affectingNatures: NaturePokeathlonStatAffectSets
}

public extension PokeathlonStat {
    /// Fetches a PokeathlonStat from pokeapi.
    /// - parameter name: The name or id of the PokeathlonStat.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .pokeathlonStat, name: name)
    }
}

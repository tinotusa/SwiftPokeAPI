//
//  PokeathlonStat.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokeathlonStat: Codable, Identifiable, Hashable {
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
    /// - parameter name: The name of the PokeathlonStat.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .pokeathlonStat, name: name)
    }
    
    /// Fetches a PokeathlonStat from pokeapi.
    /// - parameter id: The id of the PokeathlonStat.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a PokeathlonStat from pokeapi.
    /// - parameter url: The url of the PokeathlonStat.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension PokeathlonStat: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .pokeathlonStat
    }
}

extension PokeathlonStat: Comparable {
    public static func < (lhs: PokeathlonStat, rhs: PokeathlonStat) -> Bool {
        lhs.id < rhs.id
    }
}

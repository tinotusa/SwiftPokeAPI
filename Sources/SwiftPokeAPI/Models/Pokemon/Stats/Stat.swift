//
//  Stat.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct Stat: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// ID the games use for this stat.
    public let gameIndex: Int
    /// Whether this stat only exists within a battle.
    public let isBattleOnly: Bool
    /// A detail of moves which affect this stat positively or negatively.
    public let affectingMoves: MoveStatAffectSets
    /// A detail of natures which affect this stat positively or negatively.
    public let affectingNatures: NatureStatAffectSets
    /// A list of characteristics that are set on a Pokémon when its highest base stat is this stat.
    public let characteristics: [APIResource]
    /// The class of damage this stat is directly related to.
    public let moveDamageClass: NamedAPIResource?
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension Stat {
    /// Fetches a Stat from pokeapi.
    /// - parameter name: The name of a Stat.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .stat, name: name)
    }
    
    /// Fetches a Stat from pokeapi.
    /// - parameter id: The id of the Stat.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Stat from pokeapi.
    /// - parameter url: The url of the Stat.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension Stat: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .stat
    }
}

extension Stat: Comparable {
    public static func < (lhs: Stat, rhs: Stat) -> Bool {
        lhs.id < rhs.id
    }
}

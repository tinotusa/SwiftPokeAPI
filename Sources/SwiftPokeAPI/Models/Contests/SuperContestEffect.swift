//
//  SuperContestEffect.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct SuperContestEffect: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The level of appeal this super contest effect has.
    public let appeal: Int
    /// The flavor text of this super contest effect listed in different languages.
    public let flavorTextEntries: [FlavorText]
    /// A list of moves that have the effect when used in super contests.
    public let moves: [NamedAPIResource]
}

public extension SuperContestEffect {
    /// Fetches a SuperContestEffect from [pokeapi](https://pokeapi.co).
    /// - parameter id: The id of the SuperContestEffect.
    init(_ id: Int) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .superContestEffect, name: "\(id)")
    }
}

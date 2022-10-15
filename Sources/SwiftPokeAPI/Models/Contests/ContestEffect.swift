//
//  ContestEffect.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ContestEffect: Codable, Identifiable, Hashable { 
    /// The identifier for this resource.
    public let id: Int
    /// The base number of hearts the user of this move gets.
    public let appeal: Int
    /// The base number of hearts the user's opponent loses.
    public let jam: Int
    /// The result of this contest effect listed in different languages.
    public let effectEntries: [Effect]
    /// The flavor text of this contest effect listed in different languages.
    public let flavorTextEntries: [FlavorText]
}

public extension ContestEffect {
    /// Fetches the ContestEffect from [pokeapi](https://pokeapi.co).
    /// - parameter id: The id of the contest effect.
    init(_ id: Int) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .contestEffect, name: "\(id)")
    }
}

extension ContestEffect: Comparable {
    public static func < (lhs: ContestEffect, rhs: ContestEffect) -> Bool {
        lhs.id < rhs.id
    }
}

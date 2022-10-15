//
//  Ability.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct Ability: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let isMainSeries: Bool
    public let generation: NamedAPIResource
    public let names: [Name]
    public let effectEntries: [VerboseEffect]
    public let effectChanges: [AbilityEffectChange]
    public let flavorTextEntries: [AbilityFlavorText]
    public let pokemon: [AbilityPokemon]
}

public extension Ability {
    /// Fetches an Ability from pokeapi.
    /// - parameter name: The name of an Ability.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .abilities, name: name)
    }
    
    /// Fetches an Ability from pokeapi.
    /// - parameter id: The id of the Ability.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches an Ability from pokeapi.
    /// - parameter url: The url of the Ability.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension Ability: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .abilities
    }
}

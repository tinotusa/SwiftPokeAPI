//
//  Ability.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct Ability: Codable, Identifiable {
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
    /// - parameter name: The name or id of an Ability.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .abilities, name: name)
    }
}

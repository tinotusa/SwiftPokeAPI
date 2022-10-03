//
//  GrowthRate.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct GrowthRate: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The formula used to calculate the rate at which the Pokémon species gains level.
    public let formula: String
    /// The descriptions of this characteristic listed in different languages.
    public let descriptions: [Description]
    /// A list of levels and the amount of experienced needed to atain them based on this growth rate.
    public let levels: [GrowthRateExperienceLevel]
    /// A list of Pokémon species that gain levels at this growth rate.
    public let pokemonSpecies: [NamedAPIResource]
}

public extension GrowthRate {
    /// Fetches the GrowthRate of a pokemon from pokeapi.
    /// - parameter name: The name or id of the GrowthRate.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .growthRate, name: name)
    }
}
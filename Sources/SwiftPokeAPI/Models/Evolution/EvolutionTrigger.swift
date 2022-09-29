//
//  EvolutionTrigger.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct EvolutionTrigger: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of pokemon species that result from this evolution trigger.
    public let pokemonSpecies: [NamedAPIResource]
}

public extension EvolutionTrigger {
    /// Fetches an EvolutionTrigger from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name or id of the EvolutionTrigger.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .evolutionTrigger, name: name)
    }
}

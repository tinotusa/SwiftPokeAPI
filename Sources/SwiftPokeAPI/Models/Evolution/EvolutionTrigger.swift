//
//  EvolutionTrigger.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct EvolutionTrigger: Codable, Identifiable, Hashable {
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
    /// - parameter name: The name of the EvolutionTrigger.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .evolutionTrigger, name: name)
    }
    
    /// Fetches a EvolutionTrigger from pokeapi.
    /// - parameter id: The id of the EvolutionTrigger.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a EvolutionTrigger from pokeapi.
    /// - parameter url: The url of the EvolutionTrigger.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension EvolutionTrigger: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .evolutionTrigger
    }
}

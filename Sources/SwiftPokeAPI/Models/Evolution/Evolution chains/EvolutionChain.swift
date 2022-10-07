//
//  EvolutionChain.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct EvolutionChain: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The item that a Pokémon would be holding when mating that would trigger
    /// the egg hatching a baby Pokémon rather than a basic Pokémon.
    public let babyTriggerItem: NamedAPIResource?
    /// The base chain link object. Each link contains evolution details for a
    /// Pokémon in the chain. Each link references the next Pokémon in the
    /// natural evolution order.
    public let chain: ChainLink
}

public extension EvolutionChain {
    /// Fetches an EvolutionChain from [pokeapi](https://pokeapi.co).
    /// - parameter id: The id of the evolution chain.
    init(_ id: Int) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .evolutionChain, name: "\(id)")
    }
}

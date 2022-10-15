//
//  ChainLink.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ChainLink: Codable, Hashable { 
    /// Whether or not this link is for a baby Pokémon.
    /// This would only ever be true on the base link.
    public let isBaby: Bool
    /// The Pokémon species at this point in the evolution chain.
    public let species: NamedAPIResource
    /// All details regarding the specific details of the
    /// referenced Pokémon species evolution.
    public let evolutionDetails: [EvolutionDetail]
    /// A List of chain objects.
    public let evolvesTo: [ChainLink]
}

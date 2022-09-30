//
//  AbilityPokemon.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct AbilityPokemon: Codable {
    /// Whether or not this a hidden ability for the referenced Pokémon.
    public let isHidden: Bool
    /// Pokémon have 3 ability 'slots' which hold references to possible abilities
    /// they could have. This is the slot of this ability for the referenced pokemon.
    public let slot: Int
    /// The Pokémon this ability could belong to.
    public let pokemon: NamedAPIResource
}

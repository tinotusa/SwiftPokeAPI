//
//  PokemonAbility.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonAbility: Codable, Hashable {
    /// Whether or not this is a hidden ability.
    public let isHidden: Bool
    /// The slot this ability occupies in this Pokémon species.
    public let slot: Int
    /// The ability the Pokémon may have.
    public let ability: NamedAPIResource
}

//
//  PokemonSpeciesVariety.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonSpeciesVariety: Codable {
    /// Whether this variety is the default variety.
    public let isDefault: Bool
    /// The Pokémon variety.
    public let pokemon: NamedAPIResource
}

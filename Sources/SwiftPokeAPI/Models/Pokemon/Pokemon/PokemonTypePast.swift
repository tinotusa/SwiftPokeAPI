//
//  PokemonTypePast.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonTypePast: Codable, Hashable { 
    /// The last generation in which the referenced pokémon had the listed types.
    public let generation: NamedAPIResource
    /// The types the referenced pokémon had up to and including the listed generation.
    public let types: [PokemonType]
}

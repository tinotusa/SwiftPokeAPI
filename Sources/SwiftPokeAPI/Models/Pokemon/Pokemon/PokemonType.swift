//
//  PokemonType.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonType: Codable {
    /// The order the Pokémon's types are listed in.
    public let slot: Int
    /// The type the referenced Pokémon has.
    public let type: NamedAPIResource
}

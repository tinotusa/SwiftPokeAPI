//
//  PokemonFormType.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonFormType: Codable, Hashable { 
    /// The order the Pokémon's types are listed in.
    public let slot: Int
    /// The type the referenced Form has.
    public let type: NamedAPIResource
}

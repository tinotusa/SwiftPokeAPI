//
//  PokemonHeldItem.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonHeldItem: Codable, Hashable { 
    /// The item the referenced Pokémon holds.
    public let item: NamedAPIResource
    /// The details of the different versions in which the item is held.
    public let versionDetails: [PokemonHeldItemVersion]
}

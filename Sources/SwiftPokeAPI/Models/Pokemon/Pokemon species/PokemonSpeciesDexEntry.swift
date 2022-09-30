//
//  PokemonSpeciesDexEntry.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonSpeciesDexEntry: Codable {
    /// The index number within the Pokédex.
    public let entryNumber: Int
    // The Pokédex the referenced Pokémon species can be found in.
    public let pokedex: NamedAPIResource
}

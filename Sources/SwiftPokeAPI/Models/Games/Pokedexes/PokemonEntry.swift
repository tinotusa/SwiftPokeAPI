//
//  PokemonEntry.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct PokemonEntry: Codable, Hashable {
    /// The index of this Pokémon species entry within the Pokédex.
    public let entryNumber: Int
    /// The Pokémon species being encountered.
    public let pokemonSpecies: NamedAPIResource
}

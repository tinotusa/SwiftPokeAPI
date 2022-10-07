//
//  PokemonSpeciesGender.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonSpeciesGender: Codable, Hashable {
    /// The chance of this Pokémon being female, in eighths; or -1 for genderless.
    public let rate: Int
    /// A Pokémon species that can be the referenced gender.
    public let pokemonSpecies: NamedAPIResource
}

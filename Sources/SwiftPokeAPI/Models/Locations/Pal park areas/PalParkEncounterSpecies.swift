//
//  PalParkEncounterSpecies.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct PalParkEncounterSpecies: Codable, Hashable { 
    /// The base score given to the player when this Pokémon is caught during a pal park run.
    public let baseScore: Int
    /// The base rate for encountering this Pokémon in this pal park area.
    public let rate: Int
    /// The Pokémon species being encountered.
    public let pokemonSpecies: NamedAPIResource
}

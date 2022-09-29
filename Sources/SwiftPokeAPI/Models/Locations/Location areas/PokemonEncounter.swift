//
//  PokemonEncounter.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct PokemonEncounter: Codable {
    /// The Pokémon being encountered.
    public let pokemon: NamedAPIResource
    /// A list of versions and encounters with Pokémon that might happen in the referenced location area.
    public let versionDetails: [VersionEncounterDetail]
}

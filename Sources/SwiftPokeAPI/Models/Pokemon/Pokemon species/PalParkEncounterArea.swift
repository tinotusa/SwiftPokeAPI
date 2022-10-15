//
//  PalParkEncounterArea.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PalParkEncounterArea: Codable, Hashable { 
    /// The base score given to the player when the referenced Pokémon is caught during a pal park run.
    public let baseScore: Int
    /// The base rate for encountering the referenced Pokémon in this pal park area.
    public let rate: Int
    /// The pal park area where this encounter happens.
    public let area: NamedAPIResource
}

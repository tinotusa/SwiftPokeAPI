//
//  Encounter.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Encounter: Codable, Hashable { 
    /// The lowest level the Pokémon could be encountered at.
    public let minLevel: Int
    /// The highest level the Pokémon could be encountered at.
    public let maxLevel: Int
    /// A list of condition values that must be in effect for this encounter to occur.
    public let conditionValues: [NamedAPIResource]
    /// Percent chance that this encounter will occur.
    public let chance: Int
    /// The method by which this encounter happens.
    public let method: NamedAPIResource
}

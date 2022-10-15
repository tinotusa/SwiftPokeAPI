//
//  EncounterMethodRate.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct EncounterMethodRate: Codable, Hashable { 
    /// The method in which Pokémon may be encountered in an area..
    public let  encounterMethod: NamedAPIResource
    /// The chance of the encounter to occur on a version of the game.
    public let versionDetails: [EncounterVersionDetails]
}

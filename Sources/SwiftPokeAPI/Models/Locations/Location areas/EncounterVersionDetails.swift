//
//  EncounterVersionDetails.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct EncounterVersionDetails: Codable {
    /// The chance of an encounter to occur.
    public let rate: Int
    /// The version of the game in which the encounter can occur with the given chance.
    public let version: NamedAPIResource
}

//
//  VersionEncounterDetail.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct VersionEncounterDetail: Codable, Hashable {
    /// The game version this encounter happens in.
    public let version: NamedAPIResource
    /// The total percentage of all encounter potential.
    public let maxChance: Int
    /// A list of encounters and their specifics.
    public let encounterDetails: [Encounter]
}

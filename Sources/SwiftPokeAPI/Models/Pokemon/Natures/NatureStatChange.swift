//
//  NatureStatChange.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct NatureStatChange: Codable {
    /// The amount of change.
    public let maxChange: Int
    /// The stat being affected.
    public let pokeathlonStat: NamedAPIResource
}

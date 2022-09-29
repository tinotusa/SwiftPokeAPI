//
//  MoveStatChange.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveStatChange: Codable {
    /// The amount of change.
    public let change: Int
    /// The stat being affected.
    public let stat: NamedAPIResource
}

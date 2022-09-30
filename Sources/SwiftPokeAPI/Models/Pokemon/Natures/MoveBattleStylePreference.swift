//
//  MoveBattleStylePreference.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct MoveBattleStylePreference: Codable {
    /// Chance of using the move, in percent, if HP is under one half.
    public let lowHpPreference: Int
    /// Chance of using the move, in percent, if HP is over one half.
    public let highHpPreference: Int
    /// The move battle style.
    public let moveBattleStyle: NamedAPIResource
}

//
//  PastMoveStatValues.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct PastMoveStatValues: Codable, Hashable { 
    /// The percent value of how likely this move is to be successful.
    public let accuracy: Int?
    /// The percent value of how likely it is this moves effect will take effect.
    public let effectChance: Int?
    /// The base power of this move with a value of 0 if it does not have a base power.
    public let power: Int?
    /// Power points. The number of times this move can be used.
    public let pp: Int?
    /// The effect of this move listed in different languages.
    public let effectEntries: [VerboseEffect]
    /// The elemental type of this move.
    public let type: NamedAPIResource?
    /// The version group in which these move stat values were in effect.
    public let versionGroup: NamedAPIResource
}

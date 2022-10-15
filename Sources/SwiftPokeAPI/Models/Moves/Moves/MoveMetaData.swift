//
//  MoveMetaData.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveMetaData: Codable, Hashable { 
    /// The status ailment this move inflicts on its target.
    public let ailment: NamedAPIResource
    /// The category of move this move falls under, e.g. damage or ailment.
    public let category: NamedAPIResource
    /// The minimum number of times this move hits. Null if it always only hits once.
    public let minHits: Int?
    /// The maximum number of times this move hits. Null if it always only hits once.
    public let maxHits: Int?
    /// The minimum number of turns this move continues to take effect. Null if it always only lasts one turn.
    public let minTurns: Int?
    /// The maximum number of turns this move continues to take effect. Null if it always only lasts one turn.
    public let maxTurns: Int?
    /// HP drain (if positive) or Recoil damage (if negative), in percent of damage done.
    public let drain: Int
    /// The amount of hp gained by the attacking Pokemon, in percent of it's maximum HP.
    public let healing: Int
    /// Critical hit rate bonus.
    public let critRate: Int
    /// The likelihood this attack will cause an ailment.
    public let ailmentChance: Int
    /// The likelihood this attack will cause the target Pokémon to flinch.
    public let flinchChance: Int
    /// The likelihood this attack will cause a stat change in the target Pokémon.
    public let statChance: Int
}

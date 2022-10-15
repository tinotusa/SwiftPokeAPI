//
//  PokemonMoveVersion.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonMoveVersion: Codable, Hashable { 
    /// The method by which the move is learned.
    public let moveLearnMethod: NamedAPIResource
    /// The version group in which the move is learned.
    public let versionGroup: NamedAPIResource
    /// The minimum level to learn the move.
    public let levelLearnedAt: Int
}

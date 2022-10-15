//
//  PokemonStat.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonStat: Codable, Hashable { 
    /// The stat the Pokémon has.
    public let stat: NamedAPIResource
    /// The effort points (EV) the Pokémon has in the stat.
    public let effort: Int
    /// The base value of the stat.
    public let baseStat: Int
}

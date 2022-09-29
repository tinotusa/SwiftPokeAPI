//
//  ItemHolderPokemonVersionDetail.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ItemHolderPokemonVersionDetail: Codable {
    /// How often this Pokémon holds this item in this version.
    public let rarity: Int
    /// The version that this item is held in by the Pokémon.
    public let version: NamedAPIResource
}

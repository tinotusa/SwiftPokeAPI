//
//  PokemonHeldItemVersion.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonHeldItemVersion: Codable {
    /// The version in which the item is held.
    public let version: NamedAPIResource
    /// How often the item is held.
    public let rarity: Int
}

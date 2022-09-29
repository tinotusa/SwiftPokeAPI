//
//  ItemHolderPokemon.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ItemHolderPokemon: Codable {
    /// The Pokémon that holds this item.
    public let pokemon: NamedAPIResource
    /// The details for the version that this item is held in by the Pokémon.
    public let versionDetails: [ItemHolderPokemonVersionDetail]
}

//
//  PokemonMove.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonMove: Codable {
    /// The move the Pokémon can learn.
    public let move: NamedAPIResource
    /// The details of the version in which the Pokémon can learn the move.
    public let versionGroupDetails: [PokemonMoveVersion]
}

//
//  TypePokemon.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct TypePokemon: Codable, Hashable {
    /// The order the Pokémon's types are listed in.
    public let slot: Int
    /// The Pokémon that has the referenced type.
    public let pokemon: NamedAPIResource
}

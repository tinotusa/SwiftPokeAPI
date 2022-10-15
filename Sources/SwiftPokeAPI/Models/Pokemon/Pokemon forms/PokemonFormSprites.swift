//
//  PokemonFormSprites.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonFormSprites: Codable, Hashable { 
    /// The default depiction of this Pokémon form from the front in battle.
    public let frontDefault: URL?
    /// The shiny depiction of this Pokémon form from the front in battle.
    public let frontShiny: URL?
    /// The default depiction of this Pokémon form from the back in battle.
    public let backDefault: URL?
    /// The shiny depiction of this Pokémon form from the back in battle.
    public let backShiny: URL?
}

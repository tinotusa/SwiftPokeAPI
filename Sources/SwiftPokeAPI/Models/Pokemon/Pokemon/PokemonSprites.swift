//
//  PokemonSprites.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonSprites: Codable {
    /// The default depiction of this Pokémon from the front in battle.
    public let frontDefault: URL?
    /// The shiny depiction of this Pokémon from the front in battle.
    public let frontShiny: URL?
    /// The female depiction of this Pokémon from the front in battle.
    public let frontFemale: URL?
    /// The shiny female depiction of this Pokémon from the front in battle.
    public let frontShinyFemale: URL?
    /// The default depiction of this Pokémon from the back in battle.
    public let backDefault: URL?
    /// The shiny depiction of this Pokémon from the back in battle.
    public let backShiny: URL?
    /// The female depiction of this Pokémon from the back in battle.
    public let backFemale: URL?
    /// The shiny female depiction of this Pokémon from the back in battle.
    public let backShinyFemale: URL?
}

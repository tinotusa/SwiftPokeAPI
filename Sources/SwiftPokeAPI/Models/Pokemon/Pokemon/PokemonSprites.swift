//
//  PokemonSprites.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonSprites: Codable, Hashable { 
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
    
    public let other: OtherSprites
}

public struct OtherSprites: Codable, Hashable { 
    public let officialArtwork: OfficialArtwork
    public let dreamWorld: DreamWorldSprites
    public let home: HomeSprites
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
        case dreamWorld
        case home
    }
}

public struct OfficialArtwork: Codable, Hashable { 
    public let frontDefault: URL?
}

public struct DreamWorldSprites: Codable, Hashable { 
    public let frontDefault: URL?
    public let frontFemale: URL?
}

public struct HomeSprites: Codable, Hashable { 
    public let frontDefault: URL?
    public let frontFemale: URL?
    public let frontShiny: URL?
}

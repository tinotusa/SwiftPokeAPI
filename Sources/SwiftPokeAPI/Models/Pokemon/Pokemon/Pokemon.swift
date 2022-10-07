//
//  Pokemon.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct Pokemon: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The base experience gained for defeating this Pokémon.
    public let baseExperience: Int?
    /// The height of this Pokémon in decimetres.
    public let height: Int
    /// Set for exactly one Pokémon used as the default for each species.
    public let isDefault: Bool
    /// Order for sorting. Almost national order, except families are grouped together.
    public let order: Int
    /// The weight of this Pokémon in hectograms.
    public let weight: Int
    /// A list of abilities this Pokémon could potentially have.
    public let abilities: [PokemonAbility]
    /// A list of forms this Pokémon can take on.
    public let forms: [NamedAPIResource]
    /// A list of game indices relevent to Pokémon item by generation.
    public let gameIndices: [VersionGameIndex]
    /// A list of items this Pokémon may be holding when encountered.
    public let heldItems: [PokemonHeldItem]
    /// A link to a list of location areas, as well as encounter details pertaining to specific versions.
    public let locationAreaEncounters: String
    /// A list of moves along with learn methods and level details pertaining to specific version groups.
    public let moves: [PokemonMove]
    /// A list of details showing types this pokémon had in previous generations
    public let pastTypes: [PokemonTypePast]
    /// A set of sprites used to depict this Pokémon in the game. A visual representation of the various sprites can be found at [PokeAPI/sprites](https://github.com/PokeAPI/sprites#sprites)
    public let sprites: PokemonSprites
    /// The species this Pokémon belongs to.
    public let species: NamedAPIResource
    /// A list of base stat values for this Pokémon.
    public let stats: [PokemonStat]
    /// A list of details showing types this Pokémon has.
    public let types: [PokemonType]
}

public extension Pokemon {
    /// Fetches a Pokemon from pokeapi.
    /// - parameter name: The name or id of a Pokemon.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .pokemon, name: name)
    }
}

//
//  PokemonSpecies.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonSpecies: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The order in which species should be sorted. Based on National Dex order,
    /// except families are grouped together and sorted by stage.
    public let order: Int
    /// The chance of this Pokémon being female, in eighths; or -1 for genderless.
    public let genderRate: Int
    /// The base capture rate; up to 255. The higher the number, the easier the catch.
    public let captureRate: Int
    /// The happiness when caught by a normal Pokéball; up to 255. The higher the number, the happier the Pokémon.
    public let baseHappiness: Int?
    /// Whether or not this is a baby Pokémon.
    public let isBaby: Bool
    /// Whether or not this is a legendary Pokémon.
    public let isLegendary: Bool
    /// Whether or not this is a mythical Pokémon.
    public let isMythical: Bool
    /// Initial hatch counter: one must walk 255 × (hatch_counter + 1) steps before this Pokémon's
    /// egg hatches, unless utilizing bonuses like Flame Body's.
    public let hatchCounter: Int?
    /// Whether or not this Pokémon has visual gender differences.
    public let hasGenderDifferences: Bool
    /// Whether or not this Pokémon has multiple forms and can switch between them.
    public let formsSwitchable: Bool
    /// The rate at which this Pokémon species gains levels.
    public let growthRate: NamedAPIResource
    /// A list of Pokedexes and the indexes reserved within them for this Pokémon species.
    public let pokedexNumbers: [PokemonSpeciesDexEntry]
    /// A list of egg groups this Pokémon species is a member of.
    public let eggGroups: [NamedAPIResource]
    /// The color of this Pokémon for Pokédex search.
    public let color: NamedAPIResource
    /// The shape of this Pokémon for Pokédex search.
    public let shape: NamedAPIResource?
    /// The Pokémon species that evolves into this Pokemon_species.
    public let evolvesFromSpecies: NamedAPIResource?
    /// The evolution chain this Pokémon species is a member of.
    public let evolutionChain: APIResource?
    /// The habitat this Pokémon species can be encountered in.
    public let habitat: NamedAPIResource?
    /// The generation this Pokémon species was introduced in.
    public let generation: NamedAPIResource
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of encounters that can be had with this Pokémon species in pal park.
    public let palParkEncounters: [PalParkEncounterArea]
    /// A list of flavor text entries for this Pokémon species.
    public let flavorTextEntries: [FlavorText]
    /// Descriptions of different forms Pokémon take on within the Pokémon species.
    public let formDescriptions: [Description]
    /// The genus of this Pokémon species listed in multiple languages.
    public let genera: [Genus]
    /// A list of the Pokémon that exist within this Pokémon species.
    public let varieties: [PokemonSpeciesVariety]
}

public extension PokemonSpecies {
    /// Fetches a PokemonSpecies from pokeapi.
    /// - parameter name: The name of a PokemonSpecies.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .pokemonSpecies, name: name)
    }
    
    /// Fetches a PokemonSpecies from pokeapi.
    /// - parameter id: The id of the PokemonSpecies.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a PokemonSpecies from pokeapi.
    /// - parameter url: The url of the PokemonSpecies.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension PokemonSpecies: SearchableByURL { }

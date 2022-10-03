//
//  LocationArea.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct LocationArea: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The internal id of an API resource within game data.
    public let gameIndex: Int
    /// A list of methods in which Pokémon may be encountered in this area and
    /// how likely the method will occur depending on the version of the game.
    public let encounterMethodRates: [EncounterMethodRate]
    /// The region this location area can be found in.
    public let location: NamedAPIResource
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of Pokémon that can be encountered in this area along with
    /// version specific details about the encounter.
    public let pokemonEncounters: [PokemonEncounter]
}

public extension LocationArea {
    /// Fetches a LocationArea from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name or id of the LocationArea.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .locationArea, name: name)
    }
}
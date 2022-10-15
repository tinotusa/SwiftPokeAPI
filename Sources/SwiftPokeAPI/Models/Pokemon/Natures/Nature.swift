//
//  Nature.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct Nature: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The stat decreased by 10% in Pokémon with this nature.
    public let decreasedStat: NamedAPIResource?
    /// The stat increased by 10% in Pokémon with this nature.
    public let increasedStat: NamedAPIResource?
    /// The flavor hated by Pokémon with this nature.
    public let hatesFlavor: NamedAPIResource?
    /// The flavor liked by Pokémon with this nature.
    public let likesFlavor: NamedAPIResource?
    /// A list of Pokéathlon stats this nature effects and how much it effects them.
    public let pokeathlonStatChanges: [NatureStatChange]
    /// A list of battle styles and how likely a Pokémon with this nature is to use them in the Battle Palace or Battle Tent.
    public let moveBattleStylePreferences: [MoveBattleStylePreference]
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension Nature {
    /// Fetches a Nature from pokeapi.
    /// - parameter name: The name of the Nature.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .nature, name: name)
    }
    
    /// Fetches a Nature from pokeapi.
    /// - parameter id: The id of the Nature.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Nature from pokeapi.
    /// - parameter url: The url of the Nature.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension Nature: SearchableByURL { }

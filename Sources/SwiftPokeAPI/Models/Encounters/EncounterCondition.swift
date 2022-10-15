//
//  EncounterCondition.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct EncounterCondition: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of possible values for this encounter condition.
    public let values: [NamedAPIResource]
}

public extension EncounterCondition {
    /// Fetches an EncounterCondition from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name of the EncounterCondition.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .encounterContition, name: name)
    }
    
    /// Fetches a EncounterCondition from pokeapi.
    /// - parameter id: The id of the EncounterCondition.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a EncounterCondition from pokeapi.
    /// - parameter url: The url of the EncounterCondition.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension EncounterCondition: SearchableByURL { }

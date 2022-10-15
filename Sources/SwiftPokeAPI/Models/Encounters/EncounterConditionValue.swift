//
//  EncounterConditionValue.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct EncounterConditionValue: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The condition this encounter condition value pertains to.
    public let condition: NamedAPIResource
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension EncounterConditionValue {
    /// Fetches an EncounterConditionValue from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name of the EncounterConditionValue.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .encounterConditionValue, name: name)
    }
    
    /// Fetches an EncounterConditionValue from pokeapi.
    /// - parameter id: The id of the EncounterConditionValue.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches an EncounterConditionValue from pokeapi.
    /// - parameter url: The url of the EncounterConditionValue.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension EncounterConditionValue: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .encounterConditionValue
    }
}

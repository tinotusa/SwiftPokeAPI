//
//  EncounterConditionValue.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct EncounterConditionValue: Codable, Identifiable {
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
    /// - parameter name: The name or id of the EncounterConditionValue.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .encounterConditionValue, name: name)
    }
}

//
//  EncounterMethod.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct EncounterMethod: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A good value for sorting.
    public let order: Int
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension EncounterMethod {
    /// Fetches the EncounterMethod from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name or id of the EncounterMethod
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .encounterMethod, name: name)
    }
}

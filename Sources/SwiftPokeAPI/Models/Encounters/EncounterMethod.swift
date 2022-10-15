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
    /// - parameter name: The name of the EncounterMethod
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .encounterMethod, name: name)
    }
    
    /// Fetches an EncounterMethod from pokeapi.
    /// - parameter id: The id of the EncounterMethod.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches an EncounterMethod from pokeapi.
    /// - parameter url: The url of the EncounterMethod.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension EncounterMethod: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .encounterMethod
    }
}

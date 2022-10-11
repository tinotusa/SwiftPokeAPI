//
//  Version.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Version: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// The version group this version belongs to.
    public let versionGroup: NamedAPIResource
}

public extension Version {
    /// Fetches a Version from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name of the Version.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .version, name: name)
    }
    
    /// Fetches a Version from pokeapi.
    /// - parameter id: The id of the Version.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Version from pokeapi.
    /// - parameter url: The url of the Version.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

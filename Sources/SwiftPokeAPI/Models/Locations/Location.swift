//
//  Location.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Location: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The region this location can be found in.
    public let region: NamedAPIResource?
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of game indices relevent to this location by generation.
    public let gameIndices: [GenerationGameIndex]
    /// Areas that can be found within this location.
    public let areas: [NamedAPIResource]
}

public extension Location {
    /// Fetches a Location from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name of the Location.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .location, name: name)
    }
    
    /// Fetches a Location from pokeapi.
    /// - parameter id: The id of the Location.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Location from pokeapi.
    /// - parameter url: The url of the Location.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

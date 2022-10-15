//
//  BerryFlavor.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct BerryFlavor: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of the berries with this flavor.
    public let berries: [FlavorBerryMap]
    /// The contest type that correlates with this berry flavor.
    public let contestType: NamedAPIResource
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension BerryFlavor {
    /// Fetches a BerryFlavor from pokeapi.
    /// - parameter name: The name of the BerryFlavor.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .berryFlavor, name: name)
    }
    
    /// Fetches a BerryFlavor from pokeapi.
    /// - parameter id: The id of the BerryFlavor.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a BerryFlavor from pokeapi.
    /// - parameter url: The url of the BerryFlavor.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension BerryFlavor: SearchableByURL { }

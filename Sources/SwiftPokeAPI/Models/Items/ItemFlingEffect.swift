//
//  ItemFlingEffect.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ItemFlingEffect: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The result of this fling effect listed in different languages.
    public let effectEntries: [Effect]
    /// A list of items that have this fling effect.
    public let items: [NamedAPIResource]
}

public extension ItemFlingEffect {
    /// Fetchs an ItemFlingEffect from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name of the ItemFlingEffect.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .itemFlingEffect, name: name)
    }
    
    /// Fetches a FlingEffect from pokeapi.
    /// - parameter id: The id of the FlingEffect.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a FlingEffect from pokeapi.
    /// - parameter url: The url of the FlingEffect.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension ItemFlingEffect: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .itemFlingEffect
    }
}

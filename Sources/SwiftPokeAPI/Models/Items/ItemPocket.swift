//
//  ItemPocket.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ItemPocket: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of item categories that are relevant to this item pocket.
    public let categories: [NamedAPIResource]
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension ItemPocket {
    /// Fetches an ItemPocket from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name of the ItemPocket.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .itemPocket, name: name)
    }
    
    /// Fetches an ItemPocket from pokeapi.
    /// - parameter id: The id of the ItemPocket.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches an ItemPocket from pokeapi.
    /// - parameter url: The url of the ItemPocket.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension ItemPocket: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .itemPocket
    }
}

extension ItemPocket: Comparable {
    public static func < (lhs: ItemPocket, rhs: ItemPocket) -> Bool {
        lhs.id < rhs.id
    }
}

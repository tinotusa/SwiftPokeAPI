//
//  ItemPocket.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ItemPocket: Codable, Identifiable {
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
    /// - parameter name: The name or id of the ItemPocket.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .itemPocket, name: name)
    }
}

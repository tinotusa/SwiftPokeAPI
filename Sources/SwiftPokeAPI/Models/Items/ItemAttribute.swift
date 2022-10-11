//
//  ItemAttribute.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ItemAttribute: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of items that have this attribute.
    public let items: [NamedAPIResource]
    /// The name of this item attribute listed in different languages.
    public let names: [Name]
    /// The description of this item attribute listed in different languages.
    public let descriptions: [Description]
}

public extension ItemAttribute {
    /// Fetches an ItemAttribute from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name of the ItemAttribute.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .itemAttribute, name: name)
    }
    
    /// Fetches an ItemAttribute from pokeapi.
    /// - parameter id: The id of the ItemAttribute.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches an ItemAttribute from pokeapi.
    /// - parameter url: The url of the ItemAttribute.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

//
//  ItemCategory.swift
//  
//
//  Created by Tino on 15/10/2022.
//

import Foundation

public struct ItemCategory: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of items that are a part of this category.
    public let items: [NamedAPIResource]
    /// The name of this item category listed in different languages.
    public let names: [Name]
    /// The pocket items in this category would be put in.
    public let pocket: NamedAPIResource
}

public extension ItemCategory {
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: ItemCategory.self, endpoint: .itemCategory, name: name)
    }
    
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
}

extension ItemCategory: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .itemCategory
    }
    
    public init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: ItemCategory.self, url: url)
    }
}

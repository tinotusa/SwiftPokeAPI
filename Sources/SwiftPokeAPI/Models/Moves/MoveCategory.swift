//
//  MoveCategory.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveCategory: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of moves that fall into this category.
    public let moves: [NamedAPIResource]
    /// The description of this resource listed in different languages.
    public let descriptions: [Description]
}

public extension MoveCategory {
    /// Fetches a MoveCategory from pokeapi.
    /// - parameter name: The name of the MoveCategory.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .moveCategory, name: name)
    }
    
    /// Fetches a MoveCategory from pokeapi.
    /// - parameter id: The id of the MoveCategory.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a MoveCategory from pokeapi.
    /// - parameter url: The url of the MoveCategory.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension MoveCategory: SearchableByURL { }

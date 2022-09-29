//
//  MoveCategory.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveCategory: Codable, Identifiable {
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
    /// - parameter name: The name or id of the MoveCategory.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .moveCategory, name: name)
    }
}

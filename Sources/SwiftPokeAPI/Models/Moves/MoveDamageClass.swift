//
//  MoveDamageClass.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveDamageClass: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The description of this resource listed in different languages.
    public let descriptions: [Description]
    /// A list of moves that fall into this damage class.
    public let moves: [NamedAPIResource]
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension MoveDamageClass {
    /// Fetches a MoveDamageClass from pokeapi.
    /// - parameter name: The name or id of a MoveDamageClass.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .moveDamageClass, name: name)
    }
}

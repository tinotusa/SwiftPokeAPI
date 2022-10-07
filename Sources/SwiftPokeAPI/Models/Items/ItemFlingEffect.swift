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
    /// - parameter name: The name or id of the ItemFlingEffect.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .itemFlingEffect, name: name)
    }
}

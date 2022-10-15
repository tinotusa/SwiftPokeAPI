//
//  Type.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct `Type`: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A detail of how effective this type is toward others and vice versa.
    public let damageRelations: TypeRelations
    /// A list of details of how effective this type was toward others and vice versa in previous generations
    public let pastDamageRelations: [TypeRelationsPast]
    /// A list of game indices relevent to this item by generation.
    public let gameIndices: [GenerationGameIndex]
    /// The generation this type was introduced in.
    public let generation: NamedAPIResource
    /// The class of damage inflicted by this type.
    public let moveDamageClass: NamedAPIResource?
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of details of Pokémon that have this type.
    public let pokemon: [TypePokemon]
    /// A list of moves that have this type.
    public let moves: [NamedAPIResource]
}

public extension `Type` {
    /// Fetches a Type from pokeapi.
    /// - parameter name: The name a Type.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .type, name: name)
    }
    
    /// Fetches a Type from pokeapi.
    /// - parameter id: The id of the Type.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Type from pokeapi.
    /// - parameter url: The url of the Type.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension `Type`: SearchableByURL { }

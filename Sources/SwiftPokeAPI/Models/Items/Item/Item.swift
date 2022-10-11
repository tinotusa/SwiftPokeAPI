//
//  Item.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Item: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The price of this item in stores.
    public let cost: Int
    /// The power of the move Fling when used with this item.
    public let flingPower: Int?
    /// The effect of the move Fling when used with this item.
    public let flingEffect: NamedAPIResource?
    /// A list of attributes this item has.
    public let attributes: [NamedAPIResource]
    /// The category of items this item falls into.
    public let category: NamedAPIResource
    /// The effect of this ability listed in different languages.
    public let effectEntries: [VerboseEffect]
    /// The flavor text of this ability listed in different languages.
    public let flavorTextEntries: [VersionGroupFlavorText]
    /// A list of game indices relevent to this item by generation.
    public let gameIndices: [GenerationGameIndex]
    /// The name of this item listed in different languages.
    public let names: [Name]
    /// A set of sprites used to depict this item in the game.
    public let sprites: ItemSprites
    /// A list of Pokémon that might be found in the wild holding this item.
    public let heldByPokemon: [ItemHolderPokemon]
    /// An evolution chain this item requires to produce a bay during mating.
    public let babyTriggerFor: APIResource?
    /// A list of the machines related to this item.
    public let machines: [MachineVersionDetail]
}

public extension Item {
    /// Fetches the Item from [pokeapi](https://pokeapi.co).
    /// - parameter name: The name of the Item.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .item, name: name)
    }
    
    /// Fetches an Item from pokeapi.
    /// - parameter id: The id of the Item.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches an Item from pokeapi.
    /// - parameter url: The url of the Item.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

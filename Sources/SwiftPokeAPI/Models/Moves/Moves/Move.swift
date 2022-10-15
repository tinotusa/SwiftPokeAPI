//
//  Move.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Move: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The percent value of how likely this move is to be successful.
    public let accuracy: Int?
    /// The percent value of how likely it is this moves effect will happen.
    public let effectChance: Int?
    /// Power points. The number of times this move can be used.
    public let pp: Int
    /// A value between -8 and 8. Sets the order in which moves are executed during battle.
    /// See [Bulbapedia](http://bulbapedia.bulbagarden.net/wiki/Priority) for greater detail.
    public let priority: Int
    /// The base power of this move with a value of 0 if it does not have a base power.
    public let power: Int?
    /// A detail of normal and super contest combos that require this move.
    public let contestCombos: ContestComboSets?
    /// The type of appeal this move gives a Pokémon when used in a contest.
    public let contestType: NamedAPIResource?
    /// The effect the move has when used in a contest.
    public let contestEffect: APIResource?
    /// The type of damage the move inflicts on the target, e.g. physical.
    public let damageClass: NamedAPIResource
    /// The effect of this move listed in different languages.
    public let effectEntries: [VerboseEffect]
    /// The list of previous effects this move has had across version groups of the games.
    public let effectChanges: [AbilityEffectChange]
    /// List of Pokemon that can learn the move
    public let learnedByPokemon: [NamedAPIResource]
    /// The flavor text of this move listed in different languages.
    public let flavorTextEntries: [MoveFlavorText]
    /// The generation in which this move was introduced.
    public let generation: NamedAPIResource
    /// A list of the machines that teach this move.
    public let machines: [MachineVersionDetail]
    /// Metadata about this move
    public let meta: MoveMetaData
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of move resource value changes across version groups of the game.
    public let pastValues: [PastMoveStatValues]
    /// A list of stats this moves effects and how much it effects them.
    public let statChanges: [MoveStatChange]
    /// The effect the move has when used in a super contest.
    public let superContestEffect: APIResource?
    /// The type of target that will receive the effects of the attack.
    public let target: NamedAPIResource
    /// The elemental type of this move.
    public let type: NamedAPIResource
}

public extension Move {
    /// Fetches a Move from pokeapi.
    /// - parameter name: The name of a Move.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .move, name: name)
    }
    
    /// Fetches a Move from pokeapi.
    /// - parameter id: The id of the Move.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Move from pokeapi.
    /// - parameter url: The url of the Move.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension Move: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .move
    }
}

extension Move: Comparable {
    public static func < (lhs: Move, rhs: Move) -> Bool {
        lhs.id < rhs.id
    }
}

//
//  PokemonForm.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct PokemonForm: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The order in which forms should be sorted within all forms.
    /// Multiple forms may have equal order, in which case they should fall back on sorting by name.
    public let order: Int
    /// The order in which forms should be sorted within a species' forms.
    public let formOrder: Int
    /// True for exactly one form used as the default for each Pokémon.
    public let isDefault: Bool
    /// Whether or not this form can only happen during battle.
    public let isBattleOnly: Bool
    /// Whether or not this form requires mega evolution.
    public let isMega: Bool
    /// The name of this form.
    public let formName: String
    /// The Pokémon that can take on this form.
    public let pokemon: NamedAPIResource
    /// A list of details showing types this Pokémon form has.
    public let types: [PokemonFormType]
    /// A set of sprites used to depict this Pokémon form in the game.
    public let sprites: PokemonFormSprites
    /// The version group this Pokémon form was introduced in.
    public let versionGroup: NamedAPIResource
    /// The form specific full name of this Pokémon form, or empty if the form does not have a specific name.
    public let names: [Name]
    /// The form specific form name of this Pokémon form, or empty if the form does not have a specific name.
    public let formNames: [Name]
}

public extension PokemonForm {
    /// Fetches a PokemonForm from pokeapi.
    /// - parameter name: The name or id of a PokemonForm.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .pokemonForm, name: name)
    }
}

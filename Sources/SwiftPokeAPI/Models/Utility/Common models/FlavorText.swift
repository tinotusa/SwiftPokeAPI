//
//  FlavorText.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct FlavorText: Codable, Hashable {
    /// The localized flavor text for an API resource in a specific language.
    /// Note that this text is left unprocessed as it is found in game files.
    /// This means that it contains special characters that one might want to
    /// replace with their visible decodable version. Please check out this
    /// [issue](https://github.com/veekun/pokedex/issues/218#issuecomment-339841781) to find out more.
    public let flavorText: String
    /// The language this name is in.
    public let language: NamedAPIResource
    /// The game version this flavor text is extracted from.
    public let version: NamedAPIResource?
}

//
//  Genus.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct Genus: Codable, Hashable {
    /// The localized genus for the referenced Pokémon species.
    public let genus: String
    /// The language this genus is in.
    public let language: NamedAPIResource
}

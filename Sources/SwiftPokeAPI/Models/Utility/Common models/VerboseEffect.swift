//
//  VerboseEffect.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct VerboseEffect: Codable, Hashable { 
    /// The localized effect text for an API resource in a specific language.
    public let effect: String
    /// The localized effect text in brief.
    public let shortEffect: String
    /// The language this effect is in.
    public let language: NamedAPIResource
}

//
//  AbilityFlavorText.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct AbilityFlavorText: Codable {
    /// The localized name for an API resource in a specific language.
    public let flavorText: String
    /// The language this text resource is in.
    public let language: NamedAPIResource
    /// The version group that uses this flavor text.
    public let versionGroup: NamedAPIResource
}

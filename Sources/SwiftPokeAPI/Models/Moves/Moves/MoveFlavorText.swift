//
//  MoveFlavorText.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveFlavorText: Codable {
    /// The localized flavor text for an api resource in a specific language.
    public let flavorText: String
    /// The language this name is in.
    public let language: NamedAPIResource
    /// The version group that uses this flavor text.
    public let versionGroup: NamedAPIResource
}

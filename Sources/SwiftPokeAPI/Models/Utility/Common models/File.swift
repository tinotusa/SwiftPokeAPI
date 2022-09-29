//
//  VersionGroupFlavorText.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct VersionGroupFlavorText: Codable {
    /// The localized name for an API resource in a specific language.
    public let text: String
    /// The language this name is in.
    public let language: NamedAPIResource
    /// The version group which uses this flavor text.
    public let versionGroup: NamedAPIResource
}

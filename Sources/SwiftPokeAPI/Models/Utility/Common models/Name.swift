//
//  Name.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Name: Codable, Hashable {
    /// The localized name for an API resource in a specific language.
    public let name: String
    /// The language this name is in.
    public let language: NamedAPIResource
}

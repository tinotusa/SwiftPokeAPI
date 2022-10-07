//
//  AwesomeName.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct AwesomeName: Codable, Hashable {
    /// The localized "scientific" name for an API resource in a specific language.
    public let awesomeName: String
    /// The language this "scientific" name is in.
    public let language: NamedAPIResource
}

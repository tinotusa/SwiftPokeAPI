//
//  Description.swift
//  
//
//  Created by Tino on 29/9/2022.
//

public struct Description: Codable {
    /// The localized description for an API resource in a specific language.
    public let description: String
    /// The language this name is in.
    public let language: NamedAPIResource
}

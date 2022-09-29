//
//  File.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Name: Codable {
    public let name: String
    public let language: NamedAPIResource
    
    public init(name: String, language: NamedAPIResource) {
        self.name = name
        self.language = language
    }
}

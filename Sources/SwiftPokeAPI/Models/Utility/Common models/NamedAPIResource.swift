//
//  NamedAPIResource.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct NamedAPIResource: Codable {
    /// The name of the referenced resource.
    public let name: String?
    /// The URL of the referenced resource.
    public let url: URL
}

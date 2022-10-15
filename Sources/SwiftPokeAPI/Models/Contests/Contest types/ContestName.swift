//
//  ContestName.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ContestName: Codable, Hashable { 
    /// The name for this contest.
    public let name: String
    /// The color associated with this contest's name.
    public let color: String
    /// The language that this name is in.
    public let language: NamedAPIResource
}

//
//  VersionGameIndex.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct VersionGameIndex: Codable, Hashable {
    /// The internal id of an API resource within game data.
    public let gameIndex: Int
    /// The version relevent to this game index.
    public let version: NamedAPIResource
}

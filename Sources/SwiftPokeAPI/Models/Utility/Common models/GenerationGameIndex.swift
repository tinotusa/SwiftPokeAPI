//
//  GenerationGameIndex.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct GenerationGameIndex: Codable, Hashable {
    /// The internal id of an API resource within game data.
    public let gameIndex: Int
    /// The generation relevent to this game index.
    public let generation: NamedAPIResource
}

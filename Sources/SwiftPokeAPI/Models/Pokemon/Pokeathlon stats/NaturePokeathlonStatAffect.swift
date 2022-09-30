//
//  NaturePokeathlonStatAffect.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct NaturePokeathlonStatAffect: Codable {
    /// The maximum amount of change to the referenced Pokéathlon stat.
    public let maxChange: Int
    /// The nature causing the change.
    public let nature: NamedAPIResource
}

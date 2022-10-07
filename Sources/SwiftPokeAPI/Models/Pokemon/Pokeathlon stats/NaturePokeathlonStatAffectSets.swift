//
//  NaturePokeathlonStatAffectSets.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct NaturePokeathlonStatAffectSets: Codable, Hashable {
    /// A list of natures and how they change the referenced Pokéathlon stat.
    public let increase: [NaturePokeathlonStatAffect]
    /// A list of natures and how they change the referenced Pokéathlon stat.
    public let decrease: [NaturePokeathlonStatAffect]
}

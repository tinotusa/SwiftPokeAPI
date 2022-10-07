//
//  MoveStatAffectSets.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct MoveStatAffectSets: Codable, Hashable {
    /// A list of moves and how they change the referenced stat.
    public let increase: [MoveStatAffect]
    /// A list of moves and how they change the referenced stat.
    public let decrease: [MoveStatAffect]
}

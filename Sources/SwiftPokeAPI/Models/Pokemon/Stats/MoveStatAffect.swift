//
//  MoveStatAffect.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct MoveStatAffect: Codable, Hashable { 
    /// The maximum amount of change to the referenced stat.
    public let change: Int
    /// The move causing the change.
    public let move: NamedAPIResource
}

//
//  ContestComboSets.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ContestComboSets: Codable, Hashable {
    /// A detail of moves this move can be used before or after,
    /// granting additional appeal points in contests.
    public let normal: ContestComboDetail
    /// A detail of moves this move can be used before or after,
    /// granting additional appeal points in super contests.
    public let `super`: ContestComboDetail
}

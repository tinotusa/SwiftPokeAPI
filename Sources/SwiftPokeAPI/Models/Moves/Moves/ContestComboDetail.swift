//
//  ContestComboDetail.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ContestComboDetail: Codable, Hashable {
    /// A list of moves to use before this move.
    public let useBefore: [NamedAPIResource]?
    /// A list of moves to use after this move.
    public let useAfter: [NamedAPIResource]?
}

//
//  MachineVersionDetail.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MachineVersionDetail: Codable, Hashable { 
    /// The machine that teaches a move from an item.
    public let machine: APIResource
    /// The version group of this specific machine.
    public let versionGroup: NamedAPIResource
}

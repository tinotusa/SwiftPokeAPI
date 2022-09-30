//
//  NatureStatAffectSets.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct NatureStatAffectSets: Codable {
    /// A list of natures and how they change the referenced stat.
    public let increase: [NamedAPIResource]
    /// A list of nature sand how they change the referenced stat.
    public let decrease: [NamedAPIResource]
}

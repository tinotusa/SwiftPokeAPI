//
//  FlavorBerryMap.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct FlavorBerryMap: Codable {
    /// How powerful the referenced flavor is for this berry.
    public let potency: Int
    /// The berry with the referenced flavor.
    public let berry: NamedAPIResource
}

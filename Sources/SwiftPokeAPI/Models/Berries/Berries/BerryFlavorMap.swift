//
//  BerryFlavorMap.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct BerryFlavorMap: Codable {
    /// How powerful the referenced flavor is for this berry.
    public let potency: Int
    /// The referenced berry flavor.
    public let flavor: NamedAPIResource
}

//
//  TypeRelationsPast.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct TypeRelationsPast: Codable {
    /// The last generation in which the referenced type had the listed damage relations.
    public let generation: NamedAPIResource
    /// The damage relations the referenced type had up to and including the listed generation.
    public let damageRelations: TypeRelations
}

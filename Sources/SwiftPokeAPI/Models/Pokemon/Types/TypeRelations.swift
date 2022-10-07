//
//  TypeRelations.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct TypeRelations: Codable, Hashable {
    /// A list of types this type has no effect on.
    public let noDamageTo: [NamedAPIResource]
    /// A list of types this type is not very effect against.
    public let halfDamageTo: [NamedAPIResource]
    /// A list of types this type is very effect against.
    public let doubleDamageTo: [NamedAPIResource]
    /// A list of types that have no effect on this type.
    public let noDamageFrom: [NamedAPIResource]
    /// A list of types that are not very effective against this type.
    public let halfDamageFrom: [NamedAPIResource]
    /// A list of types that are very effective against this type.
    public let doubleDamageFrom: [NamedAPIResource]
}

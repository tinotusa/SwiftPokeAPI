//
//  AbilityEffectChange.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct AbilityEffectChange: Codable {
    /// The previous effect of this ability listed in different languages.
    public let effectEntries: [Effect]
    /// The version group in which the previous effect of this ability originated.
    public let versionGroup: NamedAPIResource
}

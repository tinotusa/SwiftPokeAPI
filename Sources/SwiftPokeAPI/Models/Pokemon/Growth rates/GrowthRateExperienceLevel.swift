//
//  GrowthRateExperienceLevel.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct GrowthRateExperienceLevel: Codable, Hashable { 
    /// The level gained.
    public let level: Int
    /// The amount of experience required to reach the referenced level.
    public let experience: Int
}

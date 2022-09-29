//
//  BerryFirmness.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct BerryFirmness: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of the berries with this firmness.
    public let berries: [NamedAPIResource]
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension BerryFirmness {
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .berryFirmness, name: name)
    }
}

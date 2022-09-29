//
//  BerryFlavor.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct BerryFlavor: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of the berries with this flavor.
    public let berries: [FlavorBerryMap]
    /// The contest type that correlates with this berry flavor.
    public let contestType: NamedAPIResource
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension BerryFlavor {
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .berryFlavor, name: name)
    }
}

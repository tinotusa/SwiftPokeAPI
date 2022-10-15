//
//  BerryFirmness.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct BerryFirmness: Codable, Identifiable, Hashable {
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
    /// Fetches BerryFirmess from pokeapib
    /// - parameter name: The name of the Berryfirmness.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .berryFirmness, name: name)
    }
    
    /// Fetches BerryFirmess from pokeapi.
    /// - parameter id: The id of the Berryfirmness.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a BerryFirmess from pokeapi.
    /// - parameter url: The url of the Berryfirmness.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension BerryFirmness: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .berryFirmness
    }
}

extension BerryFirmness: Comparable {
    public static func < (lhs: BerryFirmness, rhs: BerryFirmness) -> Bool {
        lhs.id < rhs.id
    }
}

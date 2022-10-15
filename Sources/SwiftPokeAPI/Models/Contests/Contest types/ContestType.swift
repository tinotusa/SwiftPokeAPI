//
//  ContestType.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ContestType: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The berry flavor that correlates with this contest type.
    public let berryFlavor: NamedAPIResource
    /// The name of this contest type listed in different languages.
    public let names: [ContestName]
}

public extension ContestType {
    /// Fetches a ContestType from pokeapi.
    /// - parameter name: The name of the ContestType.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .contestType, name: name)
    }
    
    /// Fetches a ContestType from pokeapi.
    /// - parameter id: The id of the ContestType.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a ContestType from pokeapi.
    /// - parameter url: The url of the ContestType.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension ContestType: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .contestType
    }
}

//
//  MoveTarget.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveTarget: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The description of this resource listed in different languages.
    public let descriptions: [Description]
    /// A list of moves that that are directed at this target.
    public let moves: [NamedAPIResource]
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension MoveTarget {
    /// Fetches a MoveTarget from pokeapi.
    /// - parameter name: The name of a MoveTarget.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .moveTarget, name: name)
    }
    
    /// Fetches a MoveTarget from pokeapi.
    /// - parameter id: The id of the MoveTarget.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a MoveTarget from pokeapi.
    /// - parameter url: The url of the MoveTarget.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension MoveTarget: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .moveTarget
    }
}

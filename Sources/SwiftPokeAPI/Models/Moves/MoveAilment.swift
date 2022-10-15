//
//  MoveAilment.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveAilment: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// A list of moves that cause this ailment.
    public let moves: [NamedAPIResource]
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension MoveAilment {
    /// Fetches a MoveAilment from pokeapi.
    /// - parameter name: The name of a MoveAilment
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .moveAilment, name: name)
    }
    
    /// Fetches a MoveAilment from pokeapi.
    /// - parameter id: The id of the MoveAilment.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a MoveAilment from pokeapi.
    /// - parameter url: The url of the MoveAilment.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension MoveAilment: SearchableByURL { }

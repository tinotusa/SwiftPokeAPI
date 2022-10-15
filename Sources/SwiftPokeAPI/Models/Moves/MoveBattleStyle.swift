//
//  MoveBattleStyle.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveBattleStyle: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension MoveBattleStyle {
    /// Fetches a MoveBattleStyle from pokeapi.
    /// - parameter name: The name of a MoveBattleStyle.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .moveBattleStyle, name: name)
    }
    
    /// Fetches a MoveBattleStyle from pokeapi.
    /// - parameter id: The id of the MoveBattleStyle.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a MoveBattleStyle from pokeapi.
    /// - parameter url: The url of the MoveBattleStyle.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension MoveBattleStyle: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .moveBattleStyle
    }
}

extension MoveBattleStyle: Comparable {
    public static func < (lhs: MoveBattleStyle, rhs: MoveBattleStyle) -> Bool {
        lhs.id < rhs.id
    }
}

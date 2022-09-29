//
//  ContestType.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct ContestType: Codable, Identifiable {
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
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .contestType, name: name)
    }
}

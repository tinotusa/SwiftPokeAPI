//
//  Nature.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct Nature: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let decreasedStat: NamedAPIResource?
    public let increasedStat: NamedAPIResource?
    public let hatesFlavor: NamedAPIResource?
    public let likesFlavor: NamedAPIResource?
    public let pokeathlonStatChanges: [NatureStatChange]
    public let moveBattleStylePreferences: [MoveBattleStylePreference]
    public let names: [Name]
}

public extension Nature {
    /// Fetches a Nature from pokeapi.
    /// - parameter name: The name or id of the Nature.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .nature, name: name)
    }
}

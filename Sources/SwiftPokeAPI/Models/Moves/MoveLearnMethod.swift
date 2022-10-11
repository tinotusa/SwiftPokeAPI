//
//  MoveLearnMethod.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct MoveLearnMethod: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// The description of this resource listed in different languages.
    public let descriptions: [Description]
    /// The name of this resource listed in different languages.
    public let names: [Name]
    /// A list of version groups where moves can be learned through this method.
    public let versionGroups: [NamedAPIResource]
}

public extension MoveLearnMethod {
    /// Fetchs a MoveLearnMethod from pokeapi.
    /// - parameter name: The name of a MoveLearnMethod.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .moveLearnMethod, name: name)
    }
    
    /// Fetches a MoveLearnMethod from pokeapi.
    /// - parameter id: The id of the MoveLearnMethod.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a MoveLearnMethod from pokeapi.
    /// - parameter url: The url of the MoveLearnMethod.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

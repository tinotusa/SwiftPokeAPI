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
    /// - parameter name: The name or id of a MoveLearnMethod.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .moveLearnMethod, name: name)
    }
}

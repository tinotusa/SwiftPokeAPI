//
//  Characteristic.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

public struct Characteristic: Codable, Identifiable {
    /// The identifier for this resource.
    public let id: Int
    /// The remainder of the highest stat/IV divided by 5.
    public let geneModulo: Int
    /// The possible values of the highest stat that would result in a
    /// Pokémon recieving this characteristic when divided by 5.
    public let possibleValues: [Int]
}

public extension Characteristic {
    /// Fetches a Characteristic from pokeapi.
    /// - parameter id: The id of a Characteristic.
    init(_ id: Int) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .characteristic, name: "\(id)")
    }
}

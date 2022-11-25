//
//  Machine.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Machine: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The TM or HM item that corresponds to this machine.
    public let item: NamedAPIResource
    /// The move that is taught by this machine.
    public let move: NamedAPIResource
    /// The version group that this machine applies to.
    public let versionGroup: NamedAPIResource
}

public extension Machine {
    /// Fetchs a Machine from pokeapi.
    /// - parameter id: The id of the Machine.
    init(_ id: Int) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, endpoint: .machine, name: "\(id)")
    }
    
    /// Fetchs a Machine from pokeapi.
    /// - parameter url: The url of the Machine.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension Machine: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .machine
    }
}

extension Machine: Comparable {
    public static func < (lhs: Machine, rhs: Machine) -> Bool {
        lhs.id < rhs.id
    }
}

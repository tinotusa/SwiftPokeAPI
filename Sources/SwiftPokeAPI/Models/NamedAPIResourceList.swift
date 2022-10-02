//
//  NamedAPIResourceList.swift
//  
//
//  Created by Tino on 2/10/2022.
//

import Foundation

public struct NamedAPIResourceList: Codable {
    /// The total number of resources available from this API.
    public let count: Int
    /// The URL for the next page in the list.
    public let next: URL?
    /// The URL for the previous page in the list.
    public let previous: URL?
    /// A list of named API resources.
    public let results: [NamedAPIResource]
}

public extension NamedAPIResourceList {
    /// Errors for NamedAPIResourceList.
    enum NamedAPIResourceListError: Error, LocalizedError {
        /// An error to indicate that the limit is invalid.
        case invalidLimit(limit: Int)
        /// An error to indicate that the offset is invalid.
        case invalidOffset(offset: Int)
        
        public var errorDescription: String? {
            switch self {
            case .invalidLimit(let limit):
                return "The limit (\(limit)) must be greater than 0."
            case .invalidOffset(let offset):
                return "The offset (\(offset)) must be greater than 0."
            }
        }
        
        public var recoverySuggestion: String? {
            switch self {
            case .invalidLimit:
                return "Call the function with a limit greater than 0"
            case .invalidOffset:
                return "Call the funciton with an offset greater than 0."
            }
        }
    }
}

public extension NamedAPIResourceList {
    /// Fetches a resource list from pokeapi.
    ///
    /// - parameter endpoint: The endpoint for a resource.
    /// - parameter limit: The amount of results to get.
    /// - parameter offest: The offset of the next page.
    init(_ endpoint: PokeAPIEndpoint, limit: Int = 20, offset: Int = 0) async throws {
        if limit <= 0 { throw NamedAPIResourceListError.invalidLimit(limit: limit) }
        if offset <= 0 { throw NamedAPIResourceListError.invalidOffset(offset: offset) }
        self = try await PokeAPI.shared.getResourceList(endpoint, limit: limit, offset: offset)
    }
}

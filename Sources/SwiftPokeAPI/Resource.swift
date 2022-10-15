//
//  Resource.swift
//  
//
//  Created by Tino on 15/10/2022.
//

import Foundation

/// A struct to hold a set of items.
public struct Resource<T: Codable & Hashable & SearchableByURL> {
    /// The items of the resource.
    public let items: Set<T>
    /// The next page url for the resource.
    public let next: URL?
    /// The previous page url for the resource.
    public let previous: URL?
}

public extension Resource {
    /// Creates a resource from the given endpoint.
    ///
    /// Gets items up to the limit specified. If the resource doesn't have that
    /// many items available, a number of items less than the limit will be returned.
    ///
    /// - parameter endpoint: The endpoint to get the data from.
    /// - parameter limit: The amount of item to get.
    /// - parameter offest: The offset to get the data from.
    init(limit: Int = 20, offset: Int = 0) async throws {
        if limit <= 0 {
            throw ResourceError.invalidLimit
        }
        if offset < 0 {
            throw ResourceError.invalidOffset
        }
        let resourceList = try await PokeAPI.shared.getResourceList(T.endpoint, limit: limit, offset: offset)
        let items: Set<T> = try await PokeAPI.shared.getItems(from: resourceList)
        self.items = items
        self.next = resourceList.next
        self.previous = resourceList.previous
    }
}

/// Error states for the Resource struct.
public enum ResourceError: Error {
    /// An indication that the given limit was invalid.
    case invalidLimit
    /// An indication that the given offset was invalid.
    case invalidOffset
}

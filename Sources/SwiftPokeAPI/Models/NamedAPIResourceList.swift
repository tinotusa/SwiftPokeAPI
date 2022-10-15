//
//  NamedAPIResourceList.swift
//  
//
//  Created by Tino on 2/10/2022.
//

import Foundation

public struct NamedAPIResourceList: Codable, Hashable {
    /// The total number of resources available from this API.
    public let count: Int
    /// The URL for the next page in the list.
    public let next: URL?
    /// The URL for the previous page in the list.
    public let previous: URL?
    /// A list of named API resources.
    public let results: [NamedAPIResource]
}

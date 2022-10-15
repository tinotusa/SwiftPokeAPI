//
//  SearchableByURL.swift
//  
//
//  Created by Tino on 15/10/2022.
//

import Foundation

public protocol SearchableByURL {
    init(_ url: URL) async throws
}

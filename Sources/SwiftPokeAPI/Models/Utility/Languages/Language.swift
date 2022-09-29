//
//  File.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Language: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let official: Bool
    public let iso639: String
    public let names: [Name]
    
    public init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Language.self, endpoint: .language, name: name)
    }
}

//
//  File.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

struct Language: Codable, Identifiable {
    let id: Int
    let name: String
    let official: Bool
    let iso639: String
    let names: [Name]
}

extension Language {
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Language.self, endpoint: .language, name: name)
    }
}

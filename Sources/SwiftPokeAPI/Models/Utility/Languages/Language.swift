//
//  Language.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation

public struct Language: Codable, Identifiable, Hashable {
    /// The identifier for this resource.
    public let id: Int
    /// The name for this resource.
    public let name: String
    /// Whether or not the games are published in this language.
    public let official: Bool
    /// The two-letter code of the country where this language is spoken. Note that it is not unique.
    public let iso639: String
    /// The two-letter code of the language. Note that it is not unique.
    public let iso3166: String
    /// The name of this resource listed in different languages.
    public let names: [Name]
}

public extension Language {
    /// Fetches a Langauge based on the given name.
    ///
    /// - parameter name: The name of the langauge.
    /// - throws: Throws an Error if a language by the name (or id) couldn't be found.
    init(_ name: String) async throws {
        self = try await PokeAPI.shared.getData(ofType: Language.self, endpoint: .language, name: name)
    }
    
    /// Fetches a Language from pokeapi.
    /// - parameter id: The id of the Language.
    init(_ id: Int) async throws {
        try await self.init("\(id)")
    }
    
    /// Fetches a Language from pokeapi.
    /// - parameter url: The url of the Language.
    init(_ url: URL) async throws {
        self = try await PokeAPI.shared.getData(ofType: Self.self, url: url)
    }
}

extension Language: SearchableByURL {
    public static var endpoint: PokeAPIEndpoint {
        .language
    }
}

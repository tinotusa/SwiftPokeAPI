//
//  PokeAPIError.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import Foundation

/// Errors returned by PokeAPI when fetching data.
public enum PokeAPIError: Error {
    /// The path given was invalid.
    case invalidURL(path: String)
    /// The server had a bad response.
    case invalidServerResponse(code: Int)
    
    /// Data was corrupted or invalid.
    case dataCorrupted(message: String)
    /// Key was not found in json.
    case keyNotFound(message: String)
    /// Type found in json didn't match codable struct.
    case typeMismatch(message: String)
    /// An indiation that a non optional value was expected but
    /// but null was found.
    case valueNotFound(message: String)
}

// MARK: - CustomStringConvertible conformance
extension PokeAPIError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidURL:
            return "The url invalid. path:"
        case .invalidServerResponse(let code):
            return "The server had a bad response code: \(code)."
            
        case .dataCorrupted(let message):
            return message
        case .keyNotFound(let message):
            return message
        case .typeMismatch(let message):
            return message
        case .valueNotFound(let message):
            return message
        }
    }
}

// MARK: - LocalizedError conformance
extension PokeAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The url is invalid."
        case .invalidServerResponse(let code):
            return "Server error code: \(code)."
        case .dataCorrupted(let message):
            return message
        case .keyNotFound(let message):
            return message
        case .typeMismatch(let message):
            return message
        case .valueNotFound(let message):
            return message
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .invalidURL:
            return "The url is not formed correctly."
        case .invalidServerResponse(_):
            return "The search parameter is not in the database or its a server error."
        case .dataCorrupted(_):
            return "The json data appears to be invalid."
        case .keyNotFound(_):
            return "A key that was expected wasn't found in the json."
        case .typeMismatch(_):
            return "Expected type didn't match the type in the json."
        case .valueNotFound(_):
            return "Expected value wasn't found in the json."
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .invalidURL:
            return "Check that the url is valid."
        case .invalidServerResponse:
            return """
                Check that what is being searched for is valid. If it is an internal \
                server error (500) there is nothing that can be done.
                """
            
        case .dataCorrupted(_):
            return "This is a server issue. Not much can be done."
        case .keyNotFound(_):
            return "Check that the key names match."
        case .typeMismatch(_):
            return "Check that the types match."
        case .valueNotFound(_):
            return "Check that the value being expected isn't null. If it is make the property optional."
        }
    }
}

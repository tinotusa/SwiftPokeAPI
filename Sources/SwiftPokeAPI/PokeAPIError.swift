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
    /// An indication that the data couldn't be decoded.
    case decodingError(error: DecodingError)
    /// An indication that a key was found but the type didn't match.
    case cacheDecodingError(key: String, type: Any.Type)
    /// The given file name was empty or invalid.
    case invalidFilename
}

// MARK: - CustomStringConvertible conformance
extension PokeAPIError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidURL:
            return "The url invalid. path:"
        case .invalidServerResponse(let code):
            return "The server had a bad response code: \(code)."
            
        case .decodingError(let error):
            switch error {
            case .typeMismatch(_, let context):
                return "Failed to decode data due to type mismatch - \(context.debugDescription)"
            case .valueNotFound(let type, let context):
                return "Failed to decode data. \(type) value is missing - \(context.debugDescription)"
            case .keyNotFound(let key, let context):
                return "Failed to decode data. \"\(key.stringValue)\" was not found - \(context.debugDescription)"
            case .dataCorrupted:
                return "Failed to decode data. The json is corrupted"
            @unknown default:
                return "Unknown error."
            }
        case .cacheDecodingError(let key, let type):
            return "Failed to decode type of \(type) from key: \(key)."
        case .invalidFilename:
            return "The file name was empty or invalid."
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
        case .decodingError(let error):
            switch error {
            case .typeMismatch(_, let context):
                return "Failed to decode data due to type mismatch - \(context.debugDescription)"
            case .valueNotFound(let type, let context):
                return "Failed to decode data. \(type) value is missing - \(context.debugDescription)"
            case .keyNotFound(let key, let context):
                return "Failed to decode data. \"\(key.stringValue)\" was not found - \(context.debugDescription)"
            case .dataCorrupted:
                return "Failed to decode data. The json is corrupted"
            @unknown default:
                return "Unknown error."
            }
        case .cacheDecodingError(let key, let type):
            return "Failed to decode type of \(type) from key: \(key)."
        case .invalidFilename:
            return "The file name was empty or invalid."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .invalidURL:
            return "The url is not formed correctly."
        case .invalidServerResponse(_):
            return "The search parameter is not in the database or its a server error."
        case .decodingError(let error):
            switch error {
            case .typeMismatch:
                return "The types expected did not match."
            case .valueNotFound:
                return "Found an optional value when a non optional was expected."
            case .keyNotFound:
                return "Key waan't found in the json."
            case .dataCorrupted:
                return "The json is not formed correctly."
            @unknown default:
                return "Unknown error."
            }
        case .cacheDecodingError(let key, let type):
            return "Found a value for key: \(key) in the cache but it couldn't be decoded to the given type: \(type)."
        case .invalidFilename:
            return "The file name was empty or invalid."
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
        case .decodingError(let error):
            switch error {
            case .typeMismatch:
                return "Check that the types match."
            case .valueNotFound:
                return "Check that the value being expected isn't null. If it is make the property optional."
            case .keyNotFound:
                return "Check that the key names match."
            case .dataCorrupted:
                return "This is a server issue. Not much can be done."
            @unknown default:
                return "Unknown error. No suggestion available."
            }
        case .cacheDecodingError:
            return "Check that the key is unique."
        case .invalidFilename:
            return "Check that the file name is not empty."
        }
    }
}

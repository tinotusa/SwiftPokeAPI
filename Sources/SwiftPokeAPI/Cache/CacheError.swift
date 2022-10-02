//
//  CacheError.swift
//  
//
//  Created by Tino on 1/10/2022.
//

import Foundation

/// Errors for the Cache.
public enum CacheError: Error, LocalizedError {
    /// An error indicating that encoding has failed.
    case encodingError(error: EncodingError)
    /// An error indicating that a file does't exist.
    case fileDoesNotExist(filename: String)
    
    public var errorDescription: String? {
        switch self {
        case .encodingError(let error):
            switch error {
            case .invalidValue(let value, let context):
                return "The value \(value) couldn't be encoded - \(context.codingPath)"
            @unknown default:
                return "An unknown error has occured."
            }
        case .fileDoesNotExist(let filename):
            return "The file \(filename) doesn't exit."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .encodingError(let error):
            switch error {
            case .invalidValue(let value, let context):
                return "The value \(value) couldn't be encoded - \(context.codingPath)"
            @unknown default:
                return "An unknown error has occured."
            }
        case .fileDoesNotExist(let filename):
            return "The file \(filename) doesn't exit."
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .encodingError(let error):
            switch error {
            case .invalidValue:
                return "Check that the value can be encoded."
            @unknown default:
                return "An unknown error has occured. No suggestion available."
            }
        case .fileDoesNotExist:
            return "Create the file first."
        }
    }
}

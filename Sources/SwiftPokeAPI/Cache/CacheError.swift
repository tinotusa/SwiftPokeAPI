//
//  CacheError.swift
//  
//
//  Created by Tino on 1/10/2022.
//

import Foundation

// TODO: remove this if there are no reasonabl custom errors
public enum CacheError: Error, LocalizedError {
    case encodingError(message: String)
    case fileDoesNotExist
}

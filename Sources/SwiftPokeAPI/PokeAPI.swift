//
//  PokeAPI.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation
import os

// TODO: Readme
// TODO: Remake pokemon app (maybe not)

/// An object that gets data from [pokapi.co](https://pokeapi.co).
public final class PokeAPI: ObservableObject {
    /// The shared singleton pokeapi object.
    public static var shared = PokeAPI()
    /// A boolean value representing whether or not the data should be cached.
    public var shouldCacheResults = true
    

    /// The cache for pokeapi data.
    private(set) var cache = Cache<String, Data>()
    /// An object to log the state of the class.
    private var logger = Logger(subsystem: "SwiftPokeAPI", category: "PokeAPI")
    /// The session used by the class.
    private var urlSession = URLSession.shared
    /// The decoded used by the class.
    private var decoder: JSONDecoder
    
    /// Creates new a PokeAPI object with the default settings.
    private init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        logger.debug("PokeAPI init.")
    }
}

// MARK: Functions
public extension PokeAPI {
    /// Gets the decoded data of th egiven type.
    /// - parameter type: The type of data to decode.
    /// - parameter endpoint: The endpoint to get data from.
    /// - parameter name: The name of the item to get.
    /// - returns: The decoded type.
    func getData<T: Codable>(
        ofType type: T.Type,
        endpoint: PokeAPIEndpoint,
        name: String
    ) async throws -> T {
        logger.debug("Starting to get data of type: \(type), from endpoint: \(endpoint.rawValue), with name: \(name)")
        
        let name = Self.filteredName(name)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2/\(endpoint.rawValue)/\(name)"
        
        guard let url = urlComponents.url else {
            logger.error("""
                Error failed to create url from components:
                scheme: \(urlComponents.scheme!) host: \(urlComponents.host!) \
                path: \(urlComponents.path) endpoint: \(endpoint.rawValue)
                """)
            throw PokeAPIError.invalidURL(path: urlComponents.path)
        }

        let cacheKey = url.relativePath
        if let data = cache[cacheKey] {
            do {
                let decodedData = try decoder.decode(type, from: data)
                logger.debug("Returning data from cache for key: \(cacheKey).")
                return decodedData
            } catch {
                throw PokeAPIError.cacheDecodingError(key: cacheKey, type: type)
            }
        }
        do {
            let (data, urlResponse) = try await urlSession.data(from: url)
            if let httpURLResponse = urlResponse as? HTTPURLResponse,
               !(200 ..< 300).contains(httpURLResponse.statusCode)
            {
                logger.error("Error got invalid reponse from server: \(httpURLResponse.statusCode).")
                throw PokeAPIError.invalidServerResponse(code: httpURLResponse.statusCode)
            }
            
            let decodedData = try decoder.decode(type, from: data)
            if shouldCacheResults {
                cache[cacheKey] = data
                logger.debug("Added data to cache for key: \(cacheKey).")
            }
            logger.debug("Successfully got data with name: \(name), from endpoint: \(endpoint.rawValue).")
            return decodedData
            
        } catch let error as DecodingError {
            logger.error("Failed to decode data. \(error.localizedDescription)")
            throw PokeAPIError.decodingError(error: error)
        } catch {
            logger.error("Error failed to get data. \(error)")
            throw error
        }
    }
    
    /// Returns a NamedAPIResourceList from the given endpoint.
    /// - parameter endpoint: The endpoint for the data
    /// - parameter limit: The max number of results to get.
    /// - parameter offset: The offset for the page.
    /// - returns: A NamedAPIResourceList containing the first 0 ..< limit values.
    func getResourceList(_ endpoint: PokeAPIEndpoint, limit: Int, offset: Int) async throws -> NamedAPIResourceList {
        logger.debug("Starting to get resource list.")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2/\(endpoint.rawValue)"
        urlComponents.queryItems = [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "offset", value: "\(offset)")
        ]
        
        guard let url = urlComponents.url else {
            logger.error("Failed to get url.")
            throw PokeAPIError.invalidURL(path: urlComponents.path)
        }
        
        let cacheKey = url.relativePath
        if let data = cache[cacheKey] {
            do {
                let decodedResourceList = try decoder.decode(NamedAPIResourceList.self, from: data)
                return decodedResourceList
            } catch let error as DecodingError {
                throw PokeAPIError.decodingError(error: error)
            }
        }
        
        do {
            let (data, urlResponse) = try await urlSession.data(from: url)
            if let httpResponse = urlResponse as? HTTPURLResponse,
               !validStatusCode(httpResponse.statusCode)
            {
                throw PokeAPIError.invalidServerResponse(code: httpResponse.statusCode)
            }
            
            let decodedData = try decoder.decode(NamedAPIResourceList.self, from: data)
            if shouldCacheResults {
                cache[cacheKey] = data
            }
            return decodedData
        } catch let error as DecodingError {
            throw PokeAPIError.decodingError(error: error)
        } catch {
            throw error
        }
    }
    
    /// Returns a NamedAPIResourceList from the given url.
    /// - returns: A NamedAPIResourceList.
    func getResourceList(from url: URL) async throws -> NamedAPIResourceList {
        let cacheKey = url.relativeString
        if let data = cache[cacheKey] {
            do {
                let decodedResourceList = try decoder.decode(NamedAPIResourceList.self, from: data)
                return decodedResourceList
            } catch let error as DecodingError {
                throw PokeAPIError.decodingError(error: error)
            }
        }
        
        do {
            let (data, urlResponse) = try await urlSession.data(from: url)
            if let httpResponse = urlResponse as? HTTPURLResponse,
               !validStatusCode(httpResponse.statusCode)
            {
                throw PokeAPIError.invalidServerResponse(code: httpResponse.statusCode)
            }
            
            let decodedData = try decoder.decode(NamedAPIResourceList.self, from: data)
            if shouldCacheResults {
                cache[cacheKey] = data
            }
            return decodedData
        } catch let error as DecodingError {
            throw PokeAPIError.decodingError(error: error)
        } catch {
            throw error
        }
    }
    
    /// Filteres the name given to match what pokeapi expects as valid input.
    ///
    /// Removes trailing white spaces, replaces all spaces in-between words with a hyphen, and
    /// lowercases the string.
    ///
    /// - parameter name: The name to filter
    /// - returns: The filtered name.
    static func filteredName(_ name: String) -> String {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "[\\s]+", with: "-", options: .regularExpression)
            .lowercased()
        
        return name
    }
    
    /// Clears the cache.
    func clearCache() {
        logger.error("clearCache not implemented.")
    }
    
    /// The maximum number of object the cache should hold.
    ///
    /// The default is 0. Which means the cache can store as much as it can.
    var countLimit: Int {
        get { cache.countLimit }
        set { cache.countLimit = newValue }
    }
}

private extension PokeAPI {
    /// Returns true if the given status code is valid (success).
    ///
    /// Checks that the status code is in-between 200 and 300
    ///
    /// - parameter statusCode: The status code of the reponse.
    /// - returns: True if successful status code. False othewise.
    func validStatusCode(_ statusCode: Int) -> Bool {
        (200 ..< 300).contains(statusCode)
    }
}

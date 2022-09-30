//
//  PokeAPI.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation
import os

/// An object that gets data from [pokapi.co](https://pokeapi.co).
public final class PokeAPI: ObservableObject {
    /// The shared singleton pokeapi object.
    public static var shared = PokeAPI()
    /// The cache for pokeapi data.
    private let cache = NSCache<NSString, NSData>()
    /// An object to log the state of the class.
    private var logger = Logger(subsystem: "SwiftPokeAPI", category: "PokeAPI")
    /// The session used by the class.
    private var urlSession = URLSession.shared
    /// The decoded used by the class.
    private var decoder: JSONDecoder

    // TODO: add settings (should cache clear cache etc)
    /// This shouldn't be called directly.
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

        do {
            let (data, urlResponse) = try await urlSession.data(from: url)
            if let httpURLResponse = urlResponse as? HTTPURLResponse,
               !(200 ..< 300).contains(httpURLResponse.statusCode)
            {
                logger.error("Error got invalid reponse from server: \(httpURLResponse.statusCode).")
                throw PokeAPIError.invalidServerResponse(code: httpURLResponse.statusCode)
            }
            
            let decodedData = try decoder.decode(type, from: data)
            logger.debug("Successfully got data with name: \(name), from endpoint: \(endpoint.rawValue).")
            return decodedData
            
        } catch DecodingError.dataCorrupted(_) {
            let message = "Failed to decode data from \(url). The json is corrupted"
            throw PokeAPIError.dataCorrupted(message: message)
        } catch DecodingError.keyNotFound(let key, let context) {
            let message = "Failed to decode data from \(url). \"\(key.stringValue)\" was not found - \(context.debugDescription)"
            throw PokeAPIError.keyNotFound(message: message)
        } catch DecodingError.typeMismatch(_, let context) {
            let message = "Failed to decode data from \(url) due to type mismatch - \(context.debugDescription)"
            throw PokeAPIError.typeMismatch(message: message)
        } catch DecodingError.valueNotFound(let type, let context) {
            let message = "Failed to decode data from \(url). \(type) value is missing - \(context.debugDescription)"
            throw PokeAPIError.valueNotFound(message: message)
        } catch {
            logger.error("Error failed to get data. \(error)")
            throw error
        }
    }
}

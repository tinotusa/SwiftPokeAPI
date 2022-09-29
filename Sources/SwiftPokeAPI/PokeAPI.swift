//
//  File.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation
import os

public final class PokeAPI {
    public static var shared = PokeAPI()
    
    private let cache = NSCache<NSString, NSData>()
    private var logger = Logger(subsystem: "SwiftPokeAPI", category: "PokeAPI")
    private var urlSession = URLSession.shared
    
    // TODO: add settings (should cache clear cache etc)
    
    private init() {
        logger.debug("PokeAPI init.")
    }
    
    public enum Endpoint: String {
        case pokemon = "pokemon"
        case language = "language"
    }
    
    // TODO: add localized error
    private enum PokeAPIError: Error {
        case invalidURL
        case invalidServerResponse(Int)
    }
    
    private let baseURL = "https://pokeapi.co/api/v2"
    private var decoder = JSONDecoder()
    
    public func getData<T: Codable>(ofType type: T.Type, endpoint: Endpoint, name: String) async throws -> T {
        // TODO: construct url better
        guard let url = URL(string: "\(baseURL)/\(endpoint.rawValue)/\(name)") else {
            logger.error("Error failed to create url from baseURL: \(self.baseURL) endpoint: \(endpoint.rawValue) and name: \(name).")
            throw PokeAPIError.invalidURL
        }
        do {
            let (data, urlResponse) = try await urlSession.data(from: url)
            if let httpURLResponse = urlResponse as? HTTPURLResponse,
               !(200 ..< 300).contains(httpURLResponse.statusCode)
            {
                logger.error("Error got invalid reponse from server: \(httpURLResponse.statusCode).")
                throw PokeAPIError.invalidServerResponse(httpURLResponse.statusCode)
            }
            
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch {
            logger.error("Error failed to get data. \(error.localizedDescription)")
            throw error
        }
    }
}

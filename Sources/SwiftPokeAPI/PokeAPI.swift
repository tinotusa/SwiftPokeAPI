//
//  PokeAPI.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation
import os

// TODO: add localized error
public enum PokeAPIError: Error {
    case invalidURL
    case invalidServerResponse(Int)
}

public final class PokeAPI: ObservableObject {
    public static var shared = PokeAPI()
    
    private let cache = NSCache<NSString, NSData>()
    private var logger = Logger(subsystem: "SwiftPokeAPI", category: "PokeAPI")
    private var urlSession = URLSession.shared
    private var decoder: JSONDecoder
    // TODO: add settings (should cache clear cache etc)
    
    private init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        logger.debug("PokeAPI init.")
    }
    
    public enum Endpoint: String {
        case pokemon = "pokemon"
        case language = "language"
        // berry
        case berry = "berry"
        case berryFirmness = "berry-firmness"
        case berryFlavor = "berry-flavor"
        // contest
        case contestType = "contest-type"
        case contestEffect = "contest-effect"
        case superContestEffect = "super-contest-effect"
        // encounter
        case encounterMethod = "encounter-method"
        case encounterContition = "encounter-condition"
        case encounterConditionValue = "encounter-condition-value"
        // evolution
        case evolutionChain = "evolution-chain"
        case evolutionTrigger = "evolution-trigger"
        // games
        case generation = "generation"
        case pokedex = "pokedex"
        case version = "version"
        case versionGroup = "version-group"
        // items
        case item = "item"
        case itemAttribute = "item-attribute"
        case itemFlingEffect = "item-fling-effect"
        case itemPocket = "item-pocket"
        // locations
        case location = "location"
        case locationArea = "location-area"
        case palParkArea = "pal-park-area"
        case region = "region"
        // machines
        case machine = "machine"
        // moves
        case move = "move"
        case moveAilment = "move-ailment"
        case moveBattleStyle = "move-battle-style"
        case moveCategory = "move-category"
        case moveDamageClass = "move-damage-class"
        case moveLearnMethod = "move-learn-method"
        case moveTarget = "move-target"
    }
    
    private let baseURL = "https://pokeapi.co/api/v2"
    
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

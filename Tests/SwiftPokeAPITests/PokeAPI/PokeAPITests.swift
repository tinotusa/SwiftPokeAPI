//
//  PokeAPITests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import Foundation
import XCTest
@testable import SwiftPokeAPI

final class PokeAPITests: XCTestCase {
    var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDataWithValidParameter() async throws {
        do {
            let name = "en"
            let language = try await pokeAPI.getData(ofType: Language.self, endpoint: .language, name: name)
            XCTAssertEqual(language.name, name)
        } catch {
            throw error
        }
    }
    
    func testGetDataWithInvalidParameter() async throws {
        do {
            let name = "not a thing"
            let _ = try await pokeAPI.getData(ofType: Language.self, endpoint: .language, name: name)
            XCTFail("This shouldn't happen.")
        } catch {
            XCTAssertTrue(true)
        }
    }
    
    func testGetDataWithValidEndpoint() async throws {
        do {
            let name = "en"
            let language = try await pokeAPI.getData(ofType: Language.self, endpoint: .language, name: name)
            XCTAssertEqual(language.name, name)
        } catch {
            throw error
        }
    }
    
    func testGetDataWithInvalidEndpoint() async throws {
        do {
            let name = "en"
            let _ = try await pokeAPI.getData(ofType: Language.self, endpoint: .pokemon, name: name)
            XCTFail("This shouldn't happen.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCacheAddsData() async {
        do {
            let name = "ditto"
            let _ = try await Pokemon(name)
            // This is to see that the log prints "Returning data from cache for key: <some key>"
            let _ = try await Pokemon(name)
            XCTAssertTrue(pokeAPI.cache.keys.count == 1)
        } catch {
            XCTFail("This isn't supposed to happen. Test is supposed to pass.")
        }
    }
    
    func testCacheDoesNotAddData() async {
        pokeAPI.shouldCacheResults = false
        do {
            let name = "ditto"
            let _ = try await Pokemon(name)
            XCTAssertTrue(pokeAPI.cache.keys.count == 0)
        } catch {
            XCTFail("This isn't supposed to happen. Test is supposed to pass.")
        }
    }
    
    func testCacheSavesToDiskSuccessfully() async {
        pokeAPI.cacheFilename = "testCache"
        do {
            let somePokemonID = "1"
            let _ = try await Pokemon(somePokemonID)
            try pokeAPI.saveCacheToDisk()
            let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let cachePath = cacheDirectory.appending(path: pokeAPI.cacheFilename)
            XCTAssertTrue(FileManager.default.fileExists(atPath: cachePath.path()))
        } catch {
            XCTFail("Failed to save cache to disk. \(error)")
        }
    }
    
    func testCacheDeletesFromDiskSuccessfully() async {
        pokeAPI.cacheFilename = "testCache"
        do {
            let somePokemonID = "1"
            let _ = try await Pokemon(somePokemonID)
            try pokeAPI.saveCacheToDisk()
            
            let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let cachePath = cacheDirectory.appending(path: pokeAPI.cacheFilename)
            XCTAssertTrue(FileManager.default.fileExists(atPath: cachePath.path()))
            
            try pokeAPI.deleteCacheFromDisk()
            XCTAssertFalse(FileManager.default.fileExists(atPath: cachePath.path()))
        } catch {
            XCTFail("Failed to save cache to disk. \(error)")
        }
    }
    
    func testCacheClearsSuccessFully() async {
        do {
            let pokemon = try await Pokemon("ditto")
            XCTAssertEqual(pokeAPI.cache.keys.count, 1)
            
            pokeAPI.clearCache()
            XCTAssertEqual(pokeAPI.cache.keys.count, 0)
        } catch {
            XCTFail("Failed to clear cache. \(error)")
        }
    }
    
    func testFilteredName() {
        let correctName = "test"
        let name = "  \tTest \n "
        let filteredName = PokeAPI.filteredName(name)
        XCTAssertEqual(correctName, filteredName)
        
        XCTAssertEqual("te-st", PokeAPI.filteredName("Te \n\t st"))
    }
}

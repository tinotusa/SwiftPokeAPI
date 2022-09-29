//
//  PokeAPITests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

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
}

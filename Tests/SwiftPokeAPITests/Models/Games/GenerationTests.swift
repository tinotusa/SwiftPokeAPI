//
//  GenerationTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class GenerationTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "generation-i"
        do {
            let generation = try await Generation(name)
            XCTAssertEqual(generation.name, name)
        } catch {
            XCTFail("Error with generation: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "generation-z"
        do {
            let _ = try await Generation(name)
            XCTFail("This shouldn't happen. Test was supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Error with generation: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 8 {
                group.addTask {
                    do {
                        let generation = try await Generation("\(id)")
                        XCTAssertEqual(generation.id, id)
                    } catch {
                        XCTFail("Error with generation id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

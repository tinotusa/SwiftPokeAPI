//
//  MoveDamageClassTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class MoveDamageClassTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "status"
        do {
            let moveDamageClass = try await MoveDamageClass(name)
            XCTAssertEqual(moveDamageClass.name, name)
        } catch {
            XCTFail("Failed to get MoveDamageClass with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "invalidMoveDamageClass"
        do {
            let _ = try await MoveDamageClass(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get MoveDamageClass with id: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 3 {
                group.addTask {
                    do {
                        let moveDamageClass = try await MoveDamageClass("\(id)")
                        XCTAssertEqual(moveDamageClass.id, id)
                    } catch {
                        XCTFail("Failed to get MoveDamageClass with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}




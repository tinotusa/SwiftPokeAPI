//
//  LocationTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class LocationTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "canalave-city"
        do {
            let location = try await Location(name)
            XCTAssertEqual(location.name, name)
        } catch {
            XCTFail("Failed to get Location with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "notARealLocation"
        do {
            let _ = try await Location(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get location with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        // these ids don't exist in pokeapi
        let invalidIDs = [
            255, 331, 318, 287, 144, 292, 295, 265, 240, 176,
            142, 21, 143, 145, 146, 166, 235, 251, 499,  523,  524,  525,  522, 530
        ]
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 797 where !invalidIDs.contains(id) {
                group.addTask {
                    do {
                        let location = try await Location("\(id)")
                        XCTAssertEqual(location.id, id)
                    } catch {
                        XCTFail("Failed to get location with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

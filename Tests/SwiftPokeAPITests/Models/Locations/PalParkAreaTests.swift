//
//  PalParkAreaTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class PalParkAreaTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "forest"
        do {
            let palParkArea = try await PalParkArea(name)
            XCTAssertEqual(palParkArea.name, name)
        } catch {
            XCTFail("Failed to get PalParkArea with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "notARealPalParkArea"
        do {
            let _ = try await PalParkArea(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get pal park area with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 5 {
                group.addTask {
                    do {
                        let palParkArea = try await PalParkArea("\(id)")
                        XCTAssertEqual(palParkArea.id, id)
                    } catch {
                        XCTFail("Failed to get pal park area with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

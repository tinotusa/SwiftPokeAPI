//
//  CharacteristicTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class CharacteristicTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidID() async {
        let id = 1
        do {
            let characteristic = try await Characteristic(id)
            XCTAssertEqual(characteristic.id, id)
        } catch {
            XCTFail("Failed to the Characteristic from id: \(id).\n\(error)")
        }
    }
    
    func testInitWithInvalidID() async {
        let id = 0
        do {
            let _ = try await Characteristic(id)
            XCTFail("This isn't supposed to happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTAssertTrue(true, "Failed to get Characteristing with id: \(0).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 30 {
                group.addTask {
                    do {
                        let characteristic = try await Characteristic(id)
                        XCTAssertEqual(characteristic.id, id)
                    } catch {
                        XCTFail("Failed to get characteristic from id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

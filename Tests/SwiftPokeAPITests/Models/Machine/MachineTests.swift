//
//  MachineTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class MachineTests: XCTestCase {
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
            let machine = try await Machine(id)
            XCTAssertEqual(machine.id, id)
        } catch {
            XCTFail("Failed to get Machine with id: \(id).\n\(error)")
        }
    }
    
    func testInitWithInvalidID() async {
        let id = 0
        do {
            let _ = try await Machine(id)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get location with id: \(id).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 1688 {
                group.addTask {
                    do {
                        let machine = try await Machine(id)
                        XCTAssertEqual(machine.id, id)
                    } catch {
                        XCTFail("Failed to get Machine with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}


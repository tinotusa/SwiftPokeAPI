//
//  MoveTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class MoveTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "pound"
        do {
            let move = try await Move(name)
            XCTAssertEqual(move.name, name)
        } catch {
            XCTFail("Failed to get Move with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "invalidMoveName"
        do {
            let _ = try await Move(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get Move with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        let invalidIDs = [
            830, 828, 829, 838, 834, 831, 827, 833, 837, 840, 843, 842, 836, 832, 841, 835, 844, 839
        ]
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 844 where !invalidIDs.contains(id) {
                group.addTask {
                    do {
                        let machine = try await Move("\(id)")
                        XCTAssertEqual(machine.id, id)
                    } catch {
                        XCTFail("Failed to get Move with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

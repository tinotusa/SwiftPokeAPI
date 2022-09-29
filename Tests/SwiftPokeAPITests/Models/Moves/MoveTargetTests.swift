//
//  MoveTargetTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class MoveTargetTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "specific-move"
        do {
            let moveTarget = try await MoveTarget(name)
            XCTAssertEqual(moveTarget.name, name)
        } catch {
            XCTFail("Failed to get MoveTarget with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = ""
        do {
            let _ = try await MoveTarget(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTAssertTrue(true, "Failed to get MoveTarget with id: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 15 {
                group.addTask {
                    do {
                        let moveTarget = try await MoveTarget("\(id)")
                        XCTAssertEqual(moveTarget.id, id)
                    } catch {
                        XCTFail("Failed to get MoveTarget with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}




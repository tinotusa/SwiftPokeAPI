//
//  MoveLearnMethodTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class MoveLearnMethodTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "level-up"
        do {
            let moveLearnMethod = try await MoveLearnMethod(name)
            XCTAssertEqual(moveLearnMethod.name, name)
        } catch {
            XCTFail("Failed to get MoveLearnMethod with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "invalidMoveLearnMethod"
        do {
            let _ = try await MoveLearnMethod(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get MoveLearnMethod with id: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 11 {
                group.addTask {
                    do {
                        let moveLearnMethod = try await MoveLearnMethod("\(id)")
                        XCTAssertEqual(moveLearnMethod.id, id)
                    } catch {
                        XCTFail("Failed to get MoveLearnMethod with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}




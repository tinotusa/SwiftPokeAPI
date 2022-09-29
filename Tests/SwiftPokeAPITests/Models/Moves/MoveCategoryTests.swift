//
//  MoveCategoryTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class MoveCategoryTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "ailment"
        do {
            let moveCategory = try await MoveCategory(name)
            XCTAssertEqual(moveCategory.name, name)
        } catch {
            XCTFail("Failed to get MoveCategory with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "invalidMoveCategory"
        do {
            let _ = try await MoveCategory(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get MoveCategory with id: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 0 ... 13 {
                group.addTask {
                    do {
                        let moveCategory = try await MoveCategory("\(id)")
                        XCTAssertEqual(moveCategory.id, id)
                    } catch {
                        XCTFail("Failed to get MoveCategory with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}



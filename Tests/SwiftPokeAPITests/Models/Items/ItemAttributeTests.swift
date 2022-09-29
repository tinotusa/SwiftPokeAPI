//
//  ItemAttributeTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class ItemAttributeTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "countable"
        do {
            let itemAttribute = try await ItemAttribute(name)
            XCTAssertEqual(itemAttribute.name, name)
        } catch {
            XCTFail("Failed to get item with name: \(name).\n\(error)")
        }
    }

    func testInitWithInvalidName() async {
        let name = "notAnAttribute"
        do {
            let _ = try await ItemAttribute(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Error with item attribute name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 8 {
                group.addTask {
                    do {
                        let itemAttribute = try await ItemAttribute("\(id)")
                        XCTAssertEqual(itemAttribute.id, id)
                    } catch {
                        XCTFail("Error with item attribute id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

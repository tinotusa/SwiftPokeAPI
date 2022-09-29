//
//  ItemPocketTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class ItemPocketTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "misc"
        do {
            let itemPocket = try await ItemPocket(name)
            XCTAssertEqual(itemPocket.name, name)
        } catch {
            XCTFail("Failed to get item pocket with name: \(name).\n\(error)")
        }
    }

    func testInitWithInvalidName() async {
        let name = "notAnItemPocket"
        do {
            let _ = try await ItemPocket(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Error with item pocket name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 8 {
                group.addTask {
                    do {
                        let itemPocket = try await ItemPocket("\(id)")
                        XCTAssertEqual(itemPocket.id, id)
                    } catch {
                        XCTFail("Error with item pocket id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

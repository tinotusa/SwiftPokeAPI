//
//  ItemFlingEffectTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class ItemFlingEffectTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "badly-poison"
        do {
            let itemFlingEffect = try await ItemFlingEffect(name)
            XCTAssertEqual(itemFlingEffect.name, name)
        } catch {
            XCTFail("Failed to get item fling effet with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "notAFlingEffect"
        do {
            let _ = try await ItemFlingEffect(name)
            XCTFail("This shouldn't happen. Test should have failed.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get item fling effect with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 7 {
                do {
                    let itemFlingEffect = try await ItemFlingEffect("\(id)")
                    XCTAssertEqual(itemFlingEffect.id, id)
                } catch {
                    XCTFail("Failed to get item fling effect with id: \(id).\n\(error)")
                }
            }
        }
    }
}

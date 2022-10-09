//
//  ItemTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class ItemTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async  {
        let name = "master-ball"
        do {
            let item = try await Item(name)
            XCTAssertEqual(item.name, name)
        } catch {
            XCTFail("Error with item name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "notAnItem"
        do {
            let _ = try await Item(name)
            XCTFail("Error. This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Error with item named: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 1607 {
                group.addTask {
                    do {
                        let item = try await Item("\(id)")
                        XCTAssertEqual(item.id, id)
                    } catch PokeAPIError.invalidServerResponse(let code) {
                        if code != 404 {
                            XCTFail("Error with item id: \(id). error code: \(code)")
                        }
                    } catch {
                        XCTFail("Error with item id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

//
//  ItemCategoryTests.swift
//  
//
//  Created by Tino on 15/10/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class ItemCategoryTests: XCTestCase {

    func testInitWithValidName() async throws {
        let name = "stat-boosts"
        do {
            let itemCategory = try await ItemCategory(name)
            XCTAssertEqual(itemCategory.name, name)
        } catch {
            XCTFail("Error. Test is supposed to pass. \(error)")
        }
    }
    
    func testInitWithValidIDs() async throws {
        let invalidIDS = [31]
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 51 where !invalidIDS.contains(id) {
                group.addTask {
                    do {
                        let itemCategory = try await ItemCategory(id)
                        XCTAssertEqual(itemCategory.id, id)
                    } catch {
                        XCTFail("Error. Test is supposed to pass. id: \(id) \(error)")
                    }
                }
            }
        }
    }
}

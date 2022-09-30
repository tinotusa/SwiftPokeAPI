//
//  NatureTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class NatureTests: XCTestCase {
    func testInitWithName() async{
        let name = "bold"
        do {
            let nature = try await Nature(name)
            XCTAssertEqual(nature.name, name)
        } catch {
            XCTFail("Failed to get Nature with name: \(name).\n\(error)")
        }
    }

    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 25 {
                group.addTask {
                    do {
                        let nature = try await Nature("\(id)")
                        XCTAssertEqual(nature.id, id)
                    } catch {
                        XCTFail("Failed to get Nature with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

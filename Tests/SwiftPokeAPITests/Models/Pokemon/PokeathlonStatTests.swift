//
//  PokeathlonStatTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class PokeathlonStatTests: XCTestCase {
    func testInitWithName() async {
        let name = "speed"
        do {
            let pokeathlonStat = try await PokeathlonStat(name)
            XCTAssertEqual(pokeathlonStat.name, name)
        } catch {
            XCTFail("Failed to get PokeathlonStat from name: \(name).\n\(error)")
        }
    }

    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 5 {
                group.addTask {
                    do {
                        let pokeathlonStat = try await PokeathlonStat("\(id)")
                        XCTAssertEqual(pokeathlonStat.id, id)
                    } catch {
                        XCTFail("Failed to get PokeathlonStat from id: \(id).\n\(error)")
                    }
                }
            }
        }
    }

}

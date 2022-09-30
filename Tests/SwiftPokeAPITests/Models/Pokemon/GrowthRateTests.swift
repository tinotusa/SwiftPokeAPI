//
//  GrowthRateTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class GrowthRateTests: XCTestCase {
    func testInitWithValidName() async {
        let name = "slow"
        do {
            let growthRate = try await GrowthRate(name)
            XCTAssertEqual(growthRate.name, name)
        } catch {
            XCTFail("Failed to get GrowthRate with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 6 {
                group.addTask {
                    do {
                        let growthRate = try await GrowthRate("\(id)")
                        XCTAssertEqual(growthRate.id, id)
                    } catch {
                        XCTFail("Failed to get GrowthRate from id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

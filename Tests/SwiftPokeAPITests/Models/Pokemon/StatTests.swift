//
//  StatTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class StatTests: XCTestCase {
    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 8 {
                group.addTask {
                    do {
                        let stat = try await Stat("\(id)")
                        XCTAssertEqual(stat.id, id)
                    } catch {
                        XCTFail("Failed to get Stat with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

//
//  TypeTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class TypeTests: XCTestCase {
    func testInitWithIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 18 {
                group.addTask {
                    do {
                        let type = try await Type("\(id)")
                        XCTAssertEqual(type.id, id)
                    } catch {
                        XCTFail("Failed to get Type with id: \(id).\n\(error)")
                    }
                }
            }
            for id in 10001 ... 10002 {
                group.addTask {
                    do {
                        let type = try await Type("\(id)")
                        XCTAssertEqual(type.id, id)
                    } catch {
                        XCTFail("Failed to get Type with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

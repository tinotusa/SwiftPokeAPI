//
//  GenderTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class GenderTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "female"
        do {
            let gender = try await Gender(name)
            XCTAssertEqual(gender.name, name)
        } catch {
            XCTFail("Failed to get Gender from name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "overworld"
        do {
            let _ = try await Gender(name)
            XCTFail("This isn't supposed to happen. The test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTAssertTrue(true, "Failed to get Gender with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 3 {
                group.addTask {
                    do {
                        let gender = try await Gender("\(id)")
                        XCTAssertEqual(gender.id, id)
                    } catch {
                        XCTFail("Failed to get Gender with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

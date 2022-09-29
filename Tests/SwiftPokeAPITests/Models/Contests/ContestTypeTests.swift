//
//  ContestTypeTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class ContestTypeTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitWithValidName() async {
        let name = "cool"
        do {
            let contestType = try await ContestType(name)
            XCTAssertEqual(contestType.name, name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testWithInvalidName() async {
        let name = "notAThing"
        do {
            let _ = try await ContestType(name)
            XCTFail("This shouldn't happen.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testWithValidIDS() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 5 {
                group.addTask {
                    do {
                        let contestType = try await ContestType("\(id)")
                        XCTAssertEqual(contestType.id, id)
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                }
            }
        }
    }
}

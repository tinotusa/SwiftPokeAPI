//
//  EncounterMethodTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class EncounterMethodTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitWithValidName() async {
        let name = "walk"
        do {
            let encounterMethod = try await EncounterMethod(name)
            XCTAssertEqual(encounterMethod.name, name)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "sdfsdf"
        do {
            let _ = try await EncounterMethod(name)
            XCTFail("This shouldn't happen.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testInitWithValidIDS() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 31 {
                group.addTask {
                    do {
                        let encounterMethod = try await EncounterMethod("\(id)")
                        XCTAssertEqual(encounterMethod.id, id)
                    } catch {
                        XCTFail("\(error)")
                    }
                }
            }
        }
    }
}

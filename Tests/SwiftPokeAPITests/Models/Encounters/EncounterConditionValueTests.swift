//
//  EncounterConditionValueTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class EncounterConditionValueTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitWithValidName() async {
        let name = "swarm-yes"
        do {
            let encounterConditionValue = try await EncounterConditionValue(name)
            XCTAssertEqual(encounterConditionValue.name, name)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "notAThing"
        do {
            let _ = try await EncounterConditionValue(name)
            XCTFail("This isn't supposed to happen.")
        } catch PokeAPIError.invalidServerResponse(let code){
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testInitWithValidIDS() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 71 {
                group.addTask {
                    do {
                        let encounterConditionValue = try await EncounterConditionValue("\(id)")
                        XCTAssertEqual(encounterConditionValue.id, id)
                    } catch {
                        XCTFail("\(error)")
                    }
                }
            }
        }
    }
}

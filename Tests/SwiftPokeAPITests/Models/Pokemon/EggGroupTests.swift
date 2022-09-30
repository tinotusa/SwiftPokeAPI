//
//  EggGroupTests.swift
//  
//
//  Created by Tino on 30/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class EggGroupTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "monster"
        do {
            let eggGroup = try await EggGroup(name)
            XCTAssertEqual(eggGroup.name, name)
        } catch {
            XCTFail("Failed to get EggGroup from name: \(name).\n\(error)")
        }
    }

    func testInitWithInvalidName() async {
        let name = "notValid"
        do {
            let _ = try await EggGroup(name)
            XCTFail("This isn't supposed to happen. Test should fail.")
        } catch PokeAPIError.invalidServerResponse(let code){
            XCTAssertEqual(code, 404)
        } catch {
            XCTAssertTrue(true, "Failed to get EggGroup from name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 15 {
                group.addTask {
                    do {
                        let eggGroup = try await EggGroup("\(id)")
                        XCTAssertEqual(eggGroup.id, id)
                    } catch {
                        XCTFail("Failed to get EggGroup from id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
    
}

//
//  BerryFirmnessTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class BerryFirmnessTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async throws {
        let name = "hard"
        do {
            let berryFirmness = try await BerryFirmness(name)
            XCTAssertEqual(berryFirmness.name, name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testInitWithInvalidName() async throws {
        let name = "notAThing"
        do {
            let _ = try await BerryFirmness(name)
            XCTFail("This is not supposed to happen.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 5 {
                group.addTask {
                    do {
                        let berryFirmness = try await BerryFirmness("\(id)")
                        XCTAssertEqual(berryFirmness.id, id)
                    } catch {
                        XCTFail("This isn't supposed to happen. \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

//
//  RegionTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class RegionTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "kanto"
        do {
            let region = try await Region(name)
            XCTAssertEqual(region.name, name)
        } catch {
            XCTFail("Failed to get Region with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "notARealRegion"
        do {
            let _ = try await Region(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get Region with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 9 {
                group.addTask {
                    do {
                        let region = try await Region("\(id)")
                        XCTAssertEqual(region.id, id)
                    } catch {
                        XCTFail("Failed to get region with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

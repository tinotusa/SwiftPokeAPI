//
//  LocationAreaTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class LocatiLocationAreaTestsonTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async {
        let name = "canalave-city-area"
        do {
            let location = try await LocationArea(name)
            XCTAssertEqual(location.name, name)
        } catch {
            XCTFail("Failed to get LocationArea with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "notARealLocationArea"
        do {
            let _ = try await LocationArea(name)
            XCTFail("This shouldn't happen. Test is supposed to fail.")
        } catch PokeAPIError.invalidServerResponse(let code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Failed to get location area with name: \(name).\n\(error)")
        }
    }
    
    func testInitWithValidIDs() async {
        // these ids are not in pokeapi
        let invalidIDs = [
            80, 77, 92, 71, 85, 533, 69, 71, 67, 66, 68, 78, 65, 79, 73, 85, 75, 81, 74, 77, 84, 72, 80, 93,
            87, 95, 88, 97, 90, 83, 98, 92, 94, 91, 105, 86, 99, 101, 96, 100, 102, 89, 103, 106, 234, 248,
            233, 104, 274, 322, 458, 465, 459, 460, 464, 457, 463, 462, 466, 469, 472, 471, 479, 474, 470,
            475, 476, 480, 482, 478, 473, 467, 468, 486, 485, 484, 477, 481, 530, 487, 483, 533, 529, 537,
            532, 531, 535, 539, 534, 542, 538, 541, 544, 546, 536, 543, 552, 550, 547, 545, 554, 548, 549,
            540, 560, 551, 555, 556, 553, 558, 559, 557, 574, 573, 575
        ]
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 732 where !invalidIDs.contains(id) {
                group.addTask {
                    do {
                        let location = try await LocationArea("\(id)")
                        XCTAssertEqual(location.id, id)
                    } catch {
                        XCTFail("Failed to get location area with id: \(id).\n\(error)")
                    }
                }
            }
        }
    }
}

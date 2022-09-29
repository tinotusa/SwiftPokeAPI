//
//  BerryFlavorTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class BerryFlavorTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidName() async throws {
        let name = "spicy"
        do {
            let berryFlavor = try await BerryFlavor(name)
            XCTAssertEqual(berryFlavor.name, name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInitWithInvalidName() async throws {
        let name = "NotAThing"
        do {
            let _ = try await BerryFlavor(name)
            XCTFail("This shouldn't happen.")
        } catch PokeAPIError.invalidServerResponse(let code){
            XCTAssertEqual(code, 404)
        }
    }
    
    func testInitWithValidIDS() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 5 {
                group.addTask {
                    do {
                        let berryFlavor = try await BerryFlavor("\(id)")
                        XCTAssertEqual(berryFlavor.id, id)
                    } catch {
                        XCTFail("This shouldn't happen. ids are supposed to be unique.")
                    }
                }
            }
        }
    }
}

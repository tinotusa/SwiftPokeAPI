//
//  ContestEffectTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class ContestEffectTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithValidID() async {
        let id = 1
        do {
            let contestEffect = try await ContestEffect(id)
            XCTAssertEqual(contestEffect.id, id)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testInitWithValidIDS() async {
        await withTaskGroup(of: Void.self) { group in
            for id in 1 ... 33 {
                group.addTask {
                    do {
                        let contestEffect = try await ContestEffect(id)
                        XCTAssertEqual(contestEffect.id, id)
                    } catch {
                        XCTFail("\(error)")
                    }
                }
            }
        }
    }

}

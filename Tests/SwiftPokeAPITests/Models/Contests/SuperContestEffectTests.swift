//
//  SuperContestEffectTests.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class SuperContestEffectTests: XCTestCase {
    private var pokeAPI: PokeAPI!
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWithValidID() async {
        let id = 1
        do {
            let superContestEffect = try await SuperContestEffect(id)
            XCTAssertEqual(superContestEffect.id, id)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testWithValidIDS() async {
        await withTaskGroup(of: Void.self) { group in
            // apparently there is no super contest effect with id 3 in pokeapi
            for id in 1 ... 23 where id != 3 {
                group.addTask {
                    do {
                        let superConstestEffect = try await SuperContestEffect(id)
                        XCTAssertEqual(superConstestEffect.id, id)
                    } catch {
                        XCTFail("\(error)")
                    }
                }
            }
        }
    }
}

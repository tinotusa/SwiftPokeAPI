//
//  File.swift
//  
//
//  Created by Tino on 29/9/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class LanguageTests: XCTestCase {
    func testInitWithValidName() async {
        let name = "en"
        
        do {
            let language = try await Language(name)
            XCTAssertEqual(language.name, name)
            XCTAssertEqual(language.id, 9)
            XCTAssertEqual(language.official, true)
            XCTAssertEqual(language.iso639, "en")
            XCTAssertEqual(language.iso3166, "us")
            XCTAssertEqual(language.names.count, 6)
        } catch {
            XCTFail("Not supposed to throw")
        }
    }
    
    func testInitWithInvalidName() async {
        let name = "lmao"
        do {
            let _ = try await Language(name)
            XCTFail("This shouldn't happen.")
        } catch {
            XCTAssertTrue(true)
        }
    }
    
    func testInitWithValidNames() async {
        let names = ["en", "es", "ja", "ko", "roomaji", "it", "cs", "1", "2", "3", "5"]
        
        for name in names {
            do {
                let language = try await Language(name)
                if let id = Int(name) {
                    XCTAssertEqual(language.id, id)
                } else {
                    XCTAssertEqual(language.name, name)
                }
            } catch {
                XCTFail("Failed to get language with name: \(name)")
            }
        }
    }
    
    func testInitWithInvalidNames() async throws {
        let names = ["sd", "df", "as", "eqlmao", "23", "34", "-1", "0"]
        do {
            for name in names {
                let _ = try await Language(name)
                XCTFail("Language names are supposed to be invalid.")
            }
        } catch {
            XCTAssertTrue(true)
        }
    }
}

//
//  ResourceTests.swift
//  
//
//  Created by Tino on 15/10/2022.
//

import XCTest
@testable import SwiftPokeAPI

final class ResourceTests: XCTestCase {
    func testResourceGetsItemSuccessfully() async throws {
        let limit = 20
        let resource = try await Resource<Pokemon>(limit: limit)
        XCTAssertTrue(resource.items.count <= limit)
        XCTAssertNotNil(resource.next)
        XCTAssertNil(resource.previous)
    }
    
    func testResourceWithInvalidLimit() async throws {
        do {
            let limit = -10
            let _ = try await Resource<Pokemon>(limit: limit)
        } catch ResourceError.invalidLimit {
            XCTAssertTrue(true, "Invalid limit was given.")
        } catch {
            XCTFail("Failed to get resource. \(error)")
        }
    }
    
    func testResourceWithInvalidOffset() async throws {
        do {
            let offset = 0
            let _ = try await Resource<Pokemon>(offset: offset)
        } catch ResourceError.invalidOffset {
            XCTAssertTrue(true, "Invalid offset was given.")
        } catch {
            XCTFail("Failed to get resource. \(error)")
        }
    }
    
    func testResourceWithURL() async throws {
        do {
            let limit = 20
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=0")!
            let resource = try await Resource<Pokemon>(url)
            XCTAssertTrue(resource.items.count <= 20)
        } catch {
            XCTFail("Error test was supposed to pass. \(error)")
        }
    }
}

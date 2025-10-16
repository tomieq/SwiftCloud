//
//  IPv4Tests.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

import XCTest
@testable import SwiftCloud

final class IPv4Tests: XCTestCase {
    func test_initPositive() throws {
        XCTAssertEqual(IPv4("192.168.1.12").raw, 3232235788)
        XCTAssertEqual(IPv4(3232235788).readable, "192.168.1.12")
    }
    
    func test_next() throws {
        XCTAssertEqual(IPv4("192.168.1.12").next, IPv4("192.168.1.13"))
        XCTAssertEqual(IPv4("192.168.1.255").next, IPv4("192.168.2.0"))
        XCTAssertNil(IPv4("255.255.255.255").next)
    }
    
    func test_invalidIP() throws {
        XCTAssertEqual(IPv4("192.168.1.s"), IPv4("0.0.0.0"))
        XCTAssertEqual(IPv4("192.168.1.480"), IPv4("0.0.0.0"))
    }
}

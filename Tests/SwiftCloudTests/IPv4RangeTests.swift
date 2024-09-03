//
//  IPv4RangeTests.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

import XCTest
@testable import SwiftCloud

final class IPv4RangeTests: XCTestCase {

    func test_initFromStartEnd() throws {
        let range = try IPv4Range(start: "10.4.12.0", end: "10.4.15.255")
        XCTAssertEqual(range.start.readable, "10.4.12.0")
        XCTAssertEqual(range.end.readable, "10.4.15.255")
        XCTAssertEqual(range.mask.readable, "255.255.252.0")
        XCTAssertEqual(range.cidr, "10.4.12.0/22")
    }

    func test_initFromCidr() throws {
        let range = try IPv4Range(cidr: "10.4.12.0/22")
        XCTAssertEqual(range.start.readable, "10.4.12.0")
        XCTAssertEqual(range.end.readable, "10.4.15.255")
        XCTAssertEqual(range.mask.readable, "255.255.252.0")
        XCTAssertEqual(range.cidr, "10.4.12.0/22")
    }

    func test_cidrCalculation() throws {
        let range = try IPv4Range(cidr: "192.168.1.0/24")
        XCTAssertEqual(range.cidr, "192.168.1.0/24")
    }

    func test_initFromMask() throws {
        var range = try IPv4Range(ip: "10.4.12.0", mask: "255.255.252.0")
        XCTAssertEqual(range.start.readable, "10.4.12.0")
        XCTAssertEqual(range.end.readable, "10.4.15.255")
        XCTAssertEqual(range.mask.readable, "255.255.252.0")

        range = try IPv4Range(cidr: "10.241.48.64/26")
        XCTAssertEqual(range.mask.readable, "255.255.255.192")
        XCTAssertEqual(range.cidr, "10.241.48.64/26")
    }
}

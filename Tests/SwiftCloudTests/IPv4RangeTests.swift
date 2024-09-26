//
//  IPv4RangeTests.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

import Testing
@testable import SwiftCloud

@Suite("IPv4 Range")
struct IPv4RangeTests {
    @Test("Verify initializer from start/end String")
    func verifyStartEndInitializer() async throws {
        let range = try IPv4Range(start: "10.4.12.0", end: "10.4.15.255")
        #expect(range.start.readable == "10.4.12.0")
        #expect(range.end.readable == "10.4.15.255")
        #expect(range.mask.readable == "255.255.252.0")
        #expect(range.cidr == "10.4.12.0/22")
    }
    
    @Test("Verify initializer from cidr String")
    func verifyInitFromCidr() throws {
        let range = try IPv4Range(cidr: "10.4.12.0/22")
        #expect(range.start.readable == "10.4.12.0")
        #expect(range.end.readable == "10.4.15.255")
        #expect(range.mask.readable == "255.255.252.0")
        #expect(range.cidr == "10.4.12.0/22")
    }
    
    @Test("Verify initializer from mask String")
    func verifyInitFromMask() throws {
        var range = try IPv4Range(ip: "10.4.12.0", mask: "255.255.252.0")
        #expect(range.start.readable == "10.4.12.0")
        #expect(range.end.readable == "10.4.15.255")
        #expect(range.mask.readable == "255.255.252.0")

        range = try IPv4Range(cidr: "10.241.48.64/26")
        #expect(range.mask.readable == "255.255.255.192")
        #expect(range.cidr == "10.241.48.64/26")
    }

    @Test("Verify count")
    func verifyCount() async throws {
        var range = try IPv4Range(start: "10.4.12.10", end: "10.4.12.10")
        #expect(range.count == 1)
        range = try IPv4Range(start: "10.4.12.1", end: "10.4.12.2")
        #expect(range.count == 2)
        range = try IPv4Range(start: "192.168.1.1", end: "192.168.1.255")
        #expect(range.count == 255)
    }
}

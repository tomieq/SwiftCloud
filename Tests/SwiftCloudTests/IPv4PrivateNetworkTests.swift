//
//  IPv4LocalNetworkTests.swift
//  SwiftCloud
//
//  Created by Tomasz on 26/09/2024.
//

import Testing
@testable import SwiftCloud

@Suite("IPv4 private address")
struct IPv4PrivateNetworkTests {
    @Test("Verify detects IP as private address")
    func verifyIPisPrivate() async throws {
        #expect(try IPv4("10.0.0.0").isPrivateAddress)
        #expect(try IPv4("10.255.255.23").isPrivateAddress)

        #expect(try IPv4("172.16.0.0").isPrivateAddress)
        #expect(try IPv4("172.31.255.255").isPrivateAddress)

        #expect(try IPv4("192.168.0.0").isPrivateAddress)
        #expect(try IPv4("192.168.255.255").isPrivateAddress)
        
        #expect(try IPv4("172.22.67.23").isPrivateAddress)
        #expect(try IPv4("10.122.69.135").isPrivateAddress)
        #expect(try IPv4("192.168.100.77").isPrivateAddress)
    }
}

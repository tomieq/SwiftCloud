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
        XCTAssertEqual(try IPv4("192.168.1.12").raw, 3232235788)
        XCTAssertEqual(IPv4(3232235788).readable, "192.168.1.12")
    }
}

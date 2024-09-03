//
//  IPTests.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

import XCTest
@testable import SwiftCloud

final class IPTests: XCTestCase {
    func test_initPositive() throws {
        XCTAssertEqual(try IP("192.168.1.12").raw, 3232235788)
        XCTAssertEqual(IP(3232235788).readable, "192.168.1.12")
    }
}

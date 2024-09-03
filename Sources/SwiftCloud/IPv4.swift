//
//  IPv4.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

public enum IPError: Error {
    case invalidFormat
}

public struct IPv4 {
    let readable: String
    let raw: UInt32

    init(_ text: String) throws {
        let parts = text.split(".").compactMap { UInt8($0) }
        guard parts.count == 4 else {
            throw IPError.invalidFormat
        }
        var ipAddress: UInt32 = 0
        for component in parts {
            ipAddress = ipAddress << 8
            ipAddress += UInt32(component)
        }
        self.readable = text
        self.raw = ipAddress
    }

    init(_ raw: UInt32) {
        let byte1 = (raw >> 24) & 0xFF
        let byte2 = (raw >> 16) & 0xFF
        let byte3 = (raw >> 8) & 0xFF
        let byte4 = raw & 0xFF
        self.readable = "\(byte1).\(byte2).\(byte3).\(byte4)"
        self.raw = raw
    }
}

extension IPv4: Comparable {
    public static func < (lhs: IPv4, rhs: IPv4) -> Bool {
        lhs.raw < rhs.raw
    }
}

extension IPv4: CustomStringConvertible {
    public var description: String {
        readable
    }
}

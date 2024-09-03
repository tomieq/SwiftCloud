//
//  IP.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

public enum IPError: Error {
    case invalidFormat
}

public struct IP {
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

extension IP: Comparable {
    public static func < (lhs: IP, rhs: IP) -> Bool {
        lhs.raw < rhs.raw
    }
}

extension IP: CustomStringConvertible {
    public var description: String {
        readable
    }
}

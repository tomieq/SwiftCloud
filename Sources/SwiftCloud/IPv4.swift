//
//  IPv4.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

public struct IPv4 {
    let readable: String
    let raw: UInt32

    public init(_ text: String) {
        let parts = text.split(".").compactMap { UInt8($0) }
        guard parts.count == 4 else {
            print("IPv4 init error: `\(text)` is not a valid IPv4 address, fallback to default 0.0.0.0")
            self = .init(0)
            return
        }
        var ipAddress: UInt32 = 0
        for component in parts {
            ipAddress = ipAddress << 8
            ipAddress += UInt32(component)
        }
        self.readable = text
        self.raw = ipAddress
    }

    public init(_ raw: UInt32) {
        let byte1 = (raw >> 24) & 0xFF
        let byte2 = (raw >> 16) & 0xFF
        let byte3 = (raw >> 8) & 0xFF
        let byte4 = raw & 0xFF
        self.readable = "\(byte1).\(byte2).\(byte3).\(byte4)"
        self.raw = raw
    }
    
    public var next: IPv4? {
        guard raw < .max else {
            return nil
        }
        return IPv4(raw + 1)
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

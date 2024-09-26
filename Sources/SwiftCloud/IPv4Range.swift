//
//  IPv4Range.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

public enum IpRangeError: Error {
    case invalidSyntax
}

public struct IPv4Range {
    public let start: IPv4
    public let end: IPv4
    public let mask: IPv4

    public var cidr: String {
        let diff = start.raw ^ end.raw
        let maskLength = 32 - diff.bitWidth + diff.leadingZeroBitCount
        let networkIP = IPv4(start.raw & (UInt32.max << (32 - maskLength)))
        return "\(networkIP)/\(maskLength)"
    }
    
    public var readable: String {
        "\(start.readable) - \(end.readable)"
    }
    
    public var count: Int {
        1 + Int(end.raw - start.raw)
    }

    public init(start: IPv4, end: IPv4) throws {
        self.start = start
        self.end = end
        let diff = self.start.raw ^ self.end.raw
        let maskLength = 32 - diff.bitWidth + diff.leadingZeroBitCount
        self.mask = IPv4(UInt32.max << (32 - maskLength))
    }

    public init(start: String, end: String) throws {
        try self.init(start: try IPv4(start), end: try IPv4(end))
    }

    public init(ip: String, mask: String) throws {
        let baseIP = try IPv4(ip)
        self.mask = try IPv4(mask)
        self.start = IPv4(baseIP.raw & self.mask.raw)
        self.end = IPv4(baseIP.raw | ~self.mask.raw)
    }

    // e.g. 10.241.46.0/23
    public init(cidr: String) throws {
        let components = cidr.split("/")
        guard components.count == 2,
              let ip = components.first,
              let prefixLength = Int(components.last ?? "") else {
            throw IpRangeError.invalidSyntax
        }
        let baseIP = try IPv4(ip)
        self.mask = IPv4(UInt32.max << (32 - prefixLength))
        self.start = IPv4(baseIP.raw & self.mask.raw)
        self.end = IPv4(baseIP.raw | ~self.mask.raw)
    }
}

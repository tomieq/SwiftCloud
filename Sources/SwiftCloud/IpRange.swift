//
//  IpRange.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

public enum IpRangeError: Error {
    case invalidSyntax
}

public struct IpRange {
    public let start: IP
    public let end: IP
    public let mask: IP

    public var cidr: String {
        let diff = start.raw ^ end.raw
        let maskLength = 32 - diff.bitWidth + diff.leadingZeroBitCount
        let networkIP = IP(start.raw & (UInt32.max << (32 - maskLength)))
        return "\(networkIP)/\(maskLength)"
    }
    
    public var readable: String {
        "\(start.readable) - \(end.readable)"
    }

    init(start: IP, end: IP) throws {
        self.start = start
        self.end = end
        let diff = self.start.raw ^ self.end.raw
        let maskLength = 32 - diff.bitWidth + diff.leadingZeroBitCount
        self.mask = IP(UInt32.max << (32 - maskLength))
    }

    init(start: String, end: String) throws {
        try self.init(start: try IP(start), end: try IP(end))
    }

    init(ip: String, mask: String) throws {
        let baseIP = try IP(ip)
        self.mask = try IP(mask)
        self.start = IP(baseIP.raw & self.mask.raw)
        self.end = IP(baseIP.raw | ~self.mask.raw)
    }

    // e.g. 10.241.46.0/23
    init(cidr: String) throws {
        let components = cidr.split("/")
        guard components.count == 2,
              let ip = components.first,
              let prefixLength = Int(components.last ?? "") else {
            throw IpRangeError.invalidSyntax
        }
        let baseIP = try IP(ip)
        self.mask = IP(UInt32.max << (32 - prefixLength))
        self.start = IP(baseIP.raw & self.mask.raw)
        self.end = IP(baseIP.raw | ~self.mask.raw)
    }
}

//
//  IPv4PrivateNetwork.swift
//  SwiftCloud
//
//  Created by Tomasz on 26/09/2024.
//

public struct IPv4PrivateNetwork {
    public let ranges = [
        try? IPv4Range(cidr: "10.0.0.0/8"),
        try? IPv4Range(cidr: "172.16.0.0/12"),
        try? IPv4Range(cidr: "192.168.0.0/16")
    ].compactMap { $0 }
}

extension IPv4 {
    public var isPrivateAddress: Bool {
        let localNetwork = IPv4PrivateNetwork()
        for range in localNetwork.ranges {
            if range.contains(self) {
                return true
            }
        }
        return false
    }
}

//
//  IPv4Network.swift
//  SwiftCloud
//
//  Created by Tomasz on 26/09/2024.
//

public enum IPv4NetworkError: Error {
    case rangeTooShort
}

public struct IPv4Network {
    public let networkIP: IPv4
    public let broadcastIP: IPv4
    public let range: IPv4Range
    
    init(range: IPv4Range) throws {
        guard range.count > 2 else {
            throw IPv4NetworkError.rangeTooShort
        }
        self.networkIP = range.start
        self.broadcastIP = range.end
        self.range = range
    }
}

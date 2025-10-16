//
//  IPv4+StringExpressible.swift
//  SwiftCloud
// 
//  Created by: tomieq on 16/10/2025
//

extension IPv4: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self = .init("\(value)")
    }
}

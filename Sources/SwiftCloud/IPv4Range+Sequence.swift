//
//  IPv4Range+Sequence.swift
//  SwiftCloud
// 
//  Created by: tomieq on 15/10/2025
//


extension IPv4Range: Sequence {
    
    public func makeIterator() -> IPv4RangeIterator {
        return IPv4RangeIterator(range: self)
    }
    
}

public class IPv4RangeIterator: IteratorProtocol {
    private var current: IPv4?
    private let range: IPv4Range
    
    init(range: IPv4Range) {
        self.range = range
        self.current = range.start
    }
    
    public func next() -> IPv4? {
        guard let iterator = current, iterator <= range.end else { return nil }
        defer { current = iterator.next }
        return iterator
    }
}

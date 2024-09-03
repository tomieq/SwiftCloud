//
//  String+extension.swift
//  SwiftCloud
//
//  Created by Tomasz on 03/09/2024.
//

import Foundation

extension String {
    func split(_ splitter: String) -> [String] {
        self.components(separatedBy: splitter)
    }
}

//
//  NSRegularExpression+init.swift
//  Tag
//
//
//
//  Extracted from : https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift

import Foundation

// It’s common to create NSRegularExpression instances using "try!"
// Create a convenience initializer that either creates a regex correctly or creates an assertion failure when developing
extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}


extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

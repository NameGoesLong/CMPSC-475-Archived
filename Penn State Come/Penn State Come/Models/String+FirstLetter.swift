//
//  String+FirstLetter.swift
//  Penn State Come
//
//  Created by New User on 6/10/20.
//

import Foundation

extension String {
    var firstLetter : String? {
        return self.isEmpty ? nil : String(self.first!)
    }
}

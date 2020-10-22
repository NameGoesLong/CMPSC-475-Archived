//
//  String+isNumber.swift
//  Classics
//
//  Created by New User on 21/10/20.
//

import Foundation

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

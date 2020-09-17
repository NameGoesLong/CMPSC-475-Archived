//
//  Extension.swift
//  Multiplication exercise
//
//  Created by New User on 16/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
    func count(for element : Element) -> Int{
        self.filter{$0 == element}.count
    }
}

//
//  ViewRouter.swift
//  Multiplication exercise
//
//  Created by New User on 7/9/20.
//  Copyright © 2020 Chenyin Zhang. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject{
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = "page1"{
        didSet{
            objectWillChange.send(self)
        }
    }
    
}

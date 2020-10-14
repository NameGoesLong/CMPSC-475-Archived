//
//  TimeInterval+ToHumanTime.swift
//  Penn State Come
//
//  Created by New User on 14/10/20.
//

import Foundation

extension TimeInterval{
    func stringFromTimeInterval() -> NSString {

      let ti = NSInteger(self)

      let seconds = ti % 60
      let minutes = (ti / 60) % 60
      let hours = (ti / 3600)

      return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
}

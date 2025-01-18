//
//  IntExtensions.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/4/2566 BE.
//

import Foundation

extension Int {
    public var digitCount: Int {
        return self.digits.count
    }
    
    var usefulDigits: Int {
      var count = 0
      for digit in self.digits {
          if digit != 0 && self % digit == 0 {
              count += 1
          }
      }
      return count
    }

    var isZero: Bool {
        return self == .zero
    }
}

extension BinaryInteger {
    var digits: [Int] {
      return String(describing: self).compactMap { Int(String($0)) }
    }
}

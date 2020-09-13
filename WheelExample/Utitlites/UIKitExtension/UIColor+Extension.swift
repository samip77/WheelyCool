//
//  UIColor+Extension.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

extension UIColor {
  static var colorSet: (random: UIColor, complementory: UIColor){
    let red =  CGFloat.random(in: 0...1)
    let green = CGFloat.random(in: 0...1)
    let blue = CGFloat.random(in: 0...1)
    
    let random = UIColor(
      red: red,
      green: green,
      blue: blue,
      alpha: 1.0
    )
    
    var complementory: UIColor {
      if (red + green + blue)/3 < 0.5 {
        return .white
      }
      return .black
    }
    
    return (random, complementory)
  }
}

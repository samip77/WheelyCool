//
//  UIButton+Extension.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

extension UIButton{
  func roundedFilled(with backgroundColor: UIColor, and tintColor: UIColor) {
     let cornerRadius = self.bounds.height/2
     roundedFilled(by: cornerRadius, with: backgroundColor, and: tintColor)
  }
  
  func roundedFilled(by cornerRadius: CGFloat, with backgroundColor: UIColor, and tintColor: UIColor) {
    self.layer.cornerRadius = cornerRadius
    self.layer.masksToBounds = true
    self.backgroundColor = backgroundColor
    self.tintColor = tintColor
  }
}

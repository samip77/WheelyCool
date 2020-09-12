//
//  UIView+Extension.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

extension UIView {
  func rounded(by cornerRadius:CGFloat){
    self.layer.cornerRadius = cornerRadius
    self.layer.masksToBounds = true
  }
  
  func rounded() {
    let radius = frame.size.width < frame.size.height ? frame.size.width/2 : frame.size.height/2
    rounded(by: radius)
  }
}

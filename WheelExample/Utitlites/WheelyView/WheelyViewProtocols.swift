//
//  WheelyViewProtocols.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

@objc protocol WheelyViewDataSource: AnyObject {
  func wheelyView(totalSlicesFor wheelyView: WheelyView) -> Int
  func wheelyView(_ wheeyView: WheelyView, titleFor index: Int) -> String
  func wheelyView(_ wheelyView: WheelyView, titleColorFor index: Int) -> UIColor
  func wheelyView(_ wheelyView: WheelyView, sliceColorFor index: Int) -> UIColor
 
  @objc optional func wheelyView(paddingFor wheelyView: WheelyView) -> CGFloat
  @objc optional func wheelyView(marginFor wheelyView: WheelyView) -> CGFloat
}

@objc protocol WheelyViewDelegate: AnyObject {
    func wheelyView(_ wheelyView: WheelyView, didSelectAt index: Int)
}

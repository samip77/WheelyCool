//
//  WheelViewModel.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import Foundation

class WheelViewModel {
  let items: [WheelItemViewModel]
 
  var enableSpin: Bool {
    items.count > 0
  }
  
  init(_ items: [WheelItemViewModel]) {
    self.items = items
  }
}

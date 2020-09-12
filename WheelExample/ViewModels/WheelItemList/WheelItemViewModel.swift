//
//  WheelItemViewModel.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

struct WheelItemViewModel {
  private let model: WheelItemModel
  private var (randomColor, complementaryColor) = UIColor.colorSet
  
  var title: String {
    return model.title
  }
  
  var titleColor: UIColor {
    return complementaryColor
  }
  
  var backgroundColor: UIColor {
    randomColor
  }
  
  var primaryKey: String {
    return model.id
  }
  
  init(_ model: WheelItemModel) {
    self.model = model
  }
}

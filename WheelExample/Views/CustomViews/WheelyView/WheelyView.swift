//
//  WheelyView.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit


class WheelyView: UIView {
  //MARK:- Default Settings Variables
  private let defaultPadding: CGFloat = 8.0
  private let defaultMargin: CGFloat = 16.0
  
  private let defaultNumberofSlice = 0
  internal let sliceTextWidthToRadiusRatio: CGFloat = 0.7
  internal let sliceTextHeightToRadiusRatio: CGFloat = 0.15
  
  internal let oneRotation = 2 * CGFloat.pi
  internal let defaultBaseNumberOfRotation: CGFloat = 25
  internal let defaultAnimationDuration = 5.0
  
  internal var selectedIndex: Int?
  
  //MARK:- ShapeLayers
  internal var wheelLayer = CAShapeLayer()
  internal var chosenArrowLayer = CAShapeLayer()
  
  //MARK:- Delegates and DataSource
  weak var delegate: WheelyViewDelegate?
  weak var dataSource: WheelyViewDataSource?
  
  //MARK:- Computed variables for calculation
  var padding: CGFloat {
    if let source = dataSource,
      let input = source.wheelyView?(paddingFor: self) {
      return input
    }
    
    return defaultPadding
  }
  
  var margin: CGFloat {
    if let source = dataSource,
      let input = source.wheelyView?(marginFor: self) {
      return input
    }
    
    return defaultMargin
  }
  
  var totalSlice: Int {
    if let source = dataSource {
      return source.wheelyViewTotalNumberOfSlice(self)
    }
    
    return defaultNumberofSlice
  }
  
  lazy var sliceAngle: CGFloat = {
    if totalSlice > 0 {
      return oneRotation / CGFloat(totalSlice)
    }else {
      return oneRotation
    }
  }()
  
  internal var wheelRadius: CGFloat {
    let diameter = min(bounds.width, bounds.height) - (2 * margin)
    return diameter/2
  }
  
  //MARK:- View Lifecycle
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    drawWheel(rect)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  func configure() {
    backgroundColor = .clear
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    layer.needsDisplayOnBoundsChange = true
  }
}







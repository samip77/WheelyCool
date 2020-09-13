//
//  WheelyView+Animation.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

extension WheelyView {
  func animate() {
    guard totalSlice > 0 else { return }
    let initialAngle = (CGFloat(selectedIndex ?? 0) * sliceAngle)
    
    selectedIndex = Int.random(in: 0..<totalSlice)
    let selectedAngle = (CGFloat(selectedIndex ?? 0) * sliceAngle)
    
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotationAnimation.timingFunction = .init(name: .easeInEaseOut)
    rotationAnimation.isRemovedOnCompletion = false
    rotationAnimation.fillMode = .forwards
    rotationAnimation.duration = defaultAnimationDuration
    rotationAnimation.fromValue =  initialAngle
    rotationAnimation.toValue = getTotalRotation(with: selectedAngle)
    
    rotationAnimation.delegate = self
    
    wheelLayer.add(rotationAnimation, forKey: "rotation")
  }
  
  private func getTotalRotation(with selectedAngle: CGFloat) -> CGFloat {
    let defaultRotation  = defaultBaseNumberOfRotation * oneRotation
    let totalRotation = defaultRotation + selectedAngle
    
    return totalRotation
  }
}

extension WheelyView: CAAnimationDelegate {
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    guard flag, let index = selectedIndex else { return }
    delegate?.wheelyView(self, didSelectAt: index)
  }
}

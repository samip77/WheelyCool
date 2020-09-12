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
    
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotationAnimation.timingFunction = .init(name: .easeInEaseOut)
    rotationAnimation.fromValue =  initialAngle
    rotationAnimation.duration = self.defaultAnimationDuration
    rotationAnimation.isRemovedOnCompletion = false
    rotationAnimation.fillMode = .forwards
    rotationAnimation.delegate = self
    
    selectedIndex = Int.random(in: 0..<totalSlice)
    let selectedAngle = (CGFloat(selectedIndex ?? 0) * sliceAngle)
    
    let oneRotation = 2 * CGFloat.pi
    let defaultRotation  = (CGFloat(defaultBaseNumberOfRotation) * oneRotation)
    rotationAnimation.toValue =  defaultRotation + selectedAngle
   
    wheelLayer.add(rotationAnimation, forKey: "rotation")
  }
}

extension WheelyView: CAAnimationDelegate {
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    guard flag, let index = selectedIndex else { return }
    delegate?.wheelyView(self, didSelectAt: index)
  }

}

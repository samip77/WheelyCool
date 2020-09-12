//
//  WheelyView+LayersDrawing.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

extension WheelyView {
  internal func drawChoosenMark(_ rect: CGRect) {
    chosenMarkLayer.removeFromSuperlayer()
    chosenMarkLayer.path = getSelecterPath().cgPath
    chosenMarkLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    self.layer.insertSublayer(chosenMarkLayer, above: wheelLayer)
  }
  
  private func getSelecterPath() -> UIBezierPath {
    let triangleSideLength = wheelRadius/10
    
    let firstPoint = CGPoint(x: center.x +  wheelRadius - padding - triangleSideLength/2, y: center.y)
    let secondPoint = CGPoint(x: center.x +  wheelRadius, y: center.y  + triangleSideLength/2)
    let thridPoint = CGPoint(x: center.x + wheelRadius, y: center.y - triangleSideLength/2)
    
    let bezierPath = UIBezierPath()
    bezierPath.move(to: firstPoint)
    bezierPath.addLine(to: secondPoint)
    bezierPath.addLine(to: thridPoint)
    bezierPath.close()
    
    return bezierPath
  }
  
  private func createBaseWheelLayer() {
    wheelLayer.sublayers?.removeAll()
    wheelLayer.removeFromSuperlayer()
    
    let circlePath = UIBezierPath(arcCenter: center, radius: wheelRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
       wheelLayer.path = circlePath.cgPath
       
       wheelLayer.fillColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
       wheelLayer.frame = bounds
       self.layer.addSublayer(wheelLayer)
  }
  
  internal func drawWheel(_ rect: CGRect)  {
    createBaseWheelLayer()
  
    if let source = self.dataSource {
      for index in 0..<totalSlice{
        let title = source.wheelyView(self, titleFor: index)
        let titleColor = source.wheelyView(self, titleColorFor: index)
        let sliceColor = source.wheelyView(self, sliceColorFor: index)
        
        let endAngle: CGFloat = -CGFloat(index) * sliceAngle + sliceAngle/2
        let startAngle: CGFloat = -CGFloat(index + 1) * sliceAngle + sliceAngle/2
        
        drawWheelSlice(radius: wheelRadius - padding,
                       center: center,
                       startAngle: startAngle,
                       endAngle: endAngle,
                       title: title,
                       titleColor: titleColor,
                       sliceColor: sliceColor)
      }
    }
    
    drawChoosenMark(rect)
  }
  
  internal func drawWheelSlice(radius: CGFloat,
                               center: CGPoint,
                               startAngle: CGFloat,
                               endAngle: CGFloat,
                               title: String,
                               titleColor: UIColor,
                               sliceColor: UIColor ) {
    
    let slicePath = UIBezierPath(arcCenter: center,
                                 radius: radius,
                                 startAngle: startAngle,
                                 endAngle: endAngle,
                                 clockwise: true)
    slicePath.addLine(to: center)
    slicePath.close()
    
    let sliceLayer = CAShapeLayer()
    sliceLayer.path = slicePath.cgPath
    sliceLayer.fillColor = sliceColor.cgColor
    wheelLayer.addSublayer(sliceLayer)
    
     let middleofSliceAngle = (endAngle + startAngle)/2
     addText(to: sliceLayer,
             angle: middleofSliceAngle,
             radius: radius,
             title: title,
             titleColor: titleColor)
  }
  
  private func addText(to container: CALayer,  angle: CGFloat,  radius: CGFloat, title: String, titleColor: UIColor ) {
   
  
    let pointX = center.x + (radius/2) * cos(angle)
    let pointY = center.y + (radius/2) * sin(angle)
    
    let width = radius * 0.7
    let height = radius * 0.15
    
    let size = CGSize(width: width , height: height)
    let origin = CGPoint(x: pointX - width/2, y: pointY - height/2)
    
    let textLayer = CATextLayer()
    textLayer.frame = CGRect(origin: origin, size: size)
    
    textLayer.rasterizationScale = UIScreen.main.scale
    textLayer.contentsScale = UIScreen.main.scale
    
    textLayer.isWrapped = true
    textLayer.truncationMode = .start
    textLayer.alignmentMode = .right
  
    textLayer.fontSize =  height * 0.8
    textLayer.foregroundColor = titleColor.cgColor
    textLayer.string = title
    container.addSublayer(textLayer)
    
    textLayer.setAffineTransform(CGAffineTransform(rotationAngle: angle))
  }
  
}

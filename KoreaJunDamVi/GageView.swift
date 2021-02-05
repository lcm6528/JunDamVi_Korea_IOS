//
//  GageView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 19..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

@IBDesignable

class GageView: UIView {
  
  var range: CGFloat = 100
  var currentValue
    : CGFloat = 50 {
    didSet(value) {
      animateShapeLayer()
    }
  }
  
  let backgroundLayer = CAShapeLayer()
  let foregroundLayer = CAShapeLayer()
  @IBInspectable var backgroundLayerColor: UIColor = UIColor.clear {
    didSet { configureUI() } }
  @IBInspectable var foregroundLayerColor: UIColor = UIColor.gray {
    didSet { configureUI() } }
  
  // MARK: - methods
  
  //once
  func setup() {
    
    
    
    //background layer
    backgroundLayer.fillColor = backgroundLayerColor.cgColor
    backgroundLayer.strokeEnd = 1


    layer.addSublayer(backgroundLayer)
    
    //foreground layer
    foregroundLayer.fillColor = foregroundLayerColor.cgColor
    foregroundLayer.strokeEnd = 0.0

    
    layer.addSublayer(foregroundLayer)
    
    

    
  }
  
  //when value changes in interface builder
  
  
  func configureUI() {
    backgroundLayer.strokeColor = backgroundLayerColor.cgColor
    foregroundLayer.strokeColor = foregroundLayerColor.cgColor
  }
  
  //draw when view changes
  func configureShapeLayer(shapeLayer: CAShapeLayer) {
    
    shapeLayer.frame = self.bounds
    shapeLayer.lineWidth = self.bounds.height
    shapeLayer.lineCap = CAShapeLayerLineCap.round
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: self.bounds.height/2))
    path.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.height/2))
    path.lineCapStyle = .round
    shapeLayer.path = path.cgPath
    
  }
  
  // MARK: - ui
  
  override func layoutSubviews() {
    super.layoutSubviews()
    configureShapeLayer(shapeLayer: backgroundLayer)
    configureShapeLayer(shapeLayer: foregroundLayer)
    
  }
  
  override func prepareForInterfaceBuilder() {
    setup()
    configureUI()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
    configureUI()
    
  }
  
  func animateShapeLayer() {
    var fromValue = foregroundLayer.strokeEnd
    let toValue = currentValue / range
    if let presentationLayer = foregroundLayer.presentation() {
      fromValue = presentationLayer.strokeEnd
    }
    let duration = 0.8
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    animation.fromValue = fromValue
    animation.toValue = toValue
    
    animation.duration = duration
    
    foregroundLayer.removeAnimation(forKey: "stroke")
    foregroundLayer.add(animation, forKey: "stroke")
    
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    foregroundLayer.strokeEnd = toValue
    CATransaction.commit()
  }
  
  
}

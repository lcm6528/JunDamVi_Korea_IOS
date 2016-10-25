//
//  RoundView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 10. 25..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//
import UIKit

@IBDesignable

class RoundView: UIView {
  
  // MARK: - properties
  
  var range: CGFloat = 100
  var currentValue
    : CGFloat = 0 {
    didSet { animateShapeLayer() } }
  
  let backgroundLayer = CAShapeLayer()
  let foregroundLayer = CAShapeLayer()
  @IBInspectable var backgroundLayerColor: UIColor = UIColor.black {
    didSet { configureUI() } }
  @IBInspectable var foregroundLayerColor: UIColor = UIColor.gray {
    didSet { configureUI() } }
  
  // MARK: - methods
  
  //once
  func setup() {
    let lineWidth: CGFloat = 25.0
    
    //background layer
    backgroundLayer.lineWidth = lineWidth
    backgroundLayer.fillColor = nil
    backgroundLayer.strokeEnd = 1
    layer.addSublayer(backgroundLayer)
    
    //foreground layer
    foregroundLayer.lineWidth = lineWidth
    foregroundLayer.fillColor = nil
    foregroundLayer.strokeEnd = 0.3
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
    let startAngle = degreesToRadians(value: -90.0)
    let endAngle = degreesToRadians(value: 270.0)
    let center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    let radius = self.bounds.width * 0.4
    let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
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
    let duration = 0.5
    
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

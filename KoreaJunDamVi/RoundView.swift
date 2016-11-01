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
    didSet(value) {
      
      setupContent()
      animateShapeLayer()
    }
  }
  @IBInspectable var title:String = "title" {
    didSet{
      setupContent()
    }
  }
  
  let titleLabel = UILabel()
  let separator = UIView()
  let contentLabel = UILabel()
  
  let backgroundLayer = CAShapeLayer()
  let foregroundLayer = CAShapeLayer()
  @IBInspectable var backgroundLayerColor: UIColor = UIColor.clear {
    didSet { configureUI() } }
  @IBInspectable var foregroundLayerColor: UIColor = UIColor.gray {
    didSet { configureUI() } }
  
  // MARK: - methods
  
  //once
  func setup() {
    
    
    let width = (SCREEN_WIDTH - 36)/2
    let lineWidth: CGFloat = width * 0.1
    
    
    //background layer
    backgroundLayer.lineWidth = lineWidth
    backgroundLayer.fillColor = UIColor(red: 204.0/255, green: 204.0/255, blue: 204.0/255, alpha: 1).cgColor
    backgroundLayer.strokeEnd = 1
    layer.addSublayer(backgroundLayer)
    
    //foreground layer
    foregroundLayer.lineWidth = lineWidth
    foregroundLayer.fillColor = nil
    foregroundLayer.strokeEnd = 0.0
    layer.addSublayer(foregroundLayer)
    
    
    separator.frame = CGRect(x: width * 0.175, y: width * 0.40 , width: width * 0.65, height: 2)
    separator.backgroundColor = UIColor.gray
    addSubview(separator)
    
    
    
    contentLabel.frame = CGRect(x: separator.frame.origin.x, y: width*0.42, width: separator.frame.size.width, height: width*0.25)
    contentLabel.text = " \(currentValue)%"
    contentLabel.numberOfLines = 1
    contentLabel.textAlignment = .center
    contentLabel.font = UIFont(name: "NanumGothicExtraBold", size: 40)
    contentLabel.adjustsFontSizeToFitWidth = true
    contentLabel.minimumScaleFactor = 0.1
    
    addSubview(contentLabel)
    
    
    titleLabel.frame.size = CGSize(width: separator.frame.size.width * 0.8, height: width * 0.2)
    titleLabel.center.x = separator.center.x
    titleLabel.frame.origin.y = width * 0.20
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont(name: "NanumGothicBold", size: 20)
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.1
    addSubview(titleLabel)
    
    
    
    
    bringSubview(toFront: titleLabel)
    bringSubview(toFront: separator)
    bringSubview(toFront: contentLabel)
    
    
  }
  
  //when value changes in interface builder
  
  
  func setupContent(){
    
    titleLabel.text = title
    contentLabel.text = "\(currentValue)%"
  }
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
    let radius = self.bounds.width * 0.45
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
    print("animate")
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

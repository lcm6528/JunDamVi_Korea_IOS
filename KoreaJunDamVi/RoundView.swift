//
//  RoundView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 10. 25..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//
import UIKit
import UICountingLabel
@IBDesignable

class RoundView: UIView {
  
  // MARK: - properties
  private var animate:Bool = false
  private var range: CGFloat = 100
  private var currentValue:CGFloat = 0
  
  
  var value:CGFloat{
    return currentValue
  }
  @IBInspectable var title:String = "title" {
    didSet{
      setupContent()
    }
  }
  
  let titleLabel = UILabel()
  let separator = UIView()
  let contentLabel = UICountingLabel()
  
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
    
    backgroundLayer.fillColor = UIColor.clear.cgColor
    backgroundLayer.strokeEnd = 1
    layer.addSublayer(backgroundLayer)
    
    //foreground layer
    
    foregroundLayer.fillColor = nil
    foregroundLayer.strokeEnd = 0.0
    foregroundLayer.lineCap = kCALineCapRound
    foregroundLayer.cornerRadius = 4.0
    foregroundLayer.shadowRadius = 4.0
    foregroundLayer.shadowColor = UIColor.white.cgColor
    foregroundLayer.shadowOpacity = 1
    foregroundLayer.shadowOffset = CGSize(width:-1.0, height: -1.0)
    
    
    layer.addSublayer(foregroundLayer)
    
    
    addSubview(separator)
    
//    contentLabel.attributedText = setAttForContent(value: currentValue)
    
    contentLabel.numberOfLines = 1
    contentLabel.textAlignment = .center
    contentLabel.adjustsFontSizeToFitWidth = true
    contentLabel.minimumScaleFactor = 0.1
    
    contentLabel.font = UIFont(name: "NanumBarunGothicLight", size: 36)!
    
    contentLabel.animationDuration = 0.7
    contentLabel.method = .linear
    contentLabel.formatBlock = {(value)->String? in
      let str = String(format: "%0.1f", value)
      return str + "%"
    }
    addSubview(contentLabel)
    
    
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont(name: "NanumBarunGothicLight", size: 15)
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.1
    
    addSubview(titleLabel)
    
    bringSubview(toFront: titleLabel)
    bringSubview(toFront: separator)
    bringSubview(toFront: contentLabel)
    
    
  }
  
  //when value changes in interface builder
  
  func setValue(value x:CGFloat,animate y:Bool){
    
    currentValue = x
    animate = y
    
    setupContent()
    animateShapeLayer()

  }
  
  
  func setupContent(){
    
    titleLabel.text = title
    if animate{
    contentLabel.countFromZero(to: currentValue)
    }else{
      contentLabel.text = String(format: "%0.1f%%", currentValue)
    }
    
    
    
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
    
    let width = self.frame.width
    let lineWidth: CGFloat = width * 0.08
    
    backgroundLayer.lineWidth = lineWidth
    foregroundLayer.lineWidth = lineWidth
    
    separator.frame = CGRect(x: width * 0.175, y: width * 0.40 , width: width * 0.65, height: 2)
    contentLabel.frame = CGRect(x: separator.frame.origin.x, y: width*0.43, width: separator.frame.size.width, height: width*0.27)
    
    titleLabel.frame.size = CGSize(width: separator.frame.size.width * 0.8, height: width * 0.15)
    titleLabel.center.x = separator.center.x
    titleLabel.frame.origin.y = width * 0.25
    
    
    
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
    let duration = 0.7
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
  
  
  func setAttForContent(value:CGFloat)->NSMutableAttributedString{
    
    let attStr = NSMutableAttributedString(string: "\(value)%")
    attStr.addAttributes([NSFontAttributeName: UIFont(name: "NanumBarunGothicLight", size: 36)!], range: NSRange(location: 0, length: attStr.length-1) )
    attStr.addAttributes([NSFontAttributeName: UIFont(name: "NanumBarunGothicLight", size: 22)!], range: NSRange(location: attStr.length-1, length: 1) )
    return attStr
    
    
  }
}

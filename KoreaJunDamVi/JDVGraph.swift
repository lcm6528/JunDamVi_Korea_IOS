//
//  RoundView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 10. 25..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//
import UIKit

@IBDesignable

class JDVGraph: UIView {
  
  // MARK: - properties
  private var animate:Bool = false
  private var range: CGFloat = 100
  private var currentValue:CGFloat = 0
  private var numberOfRows:Int = 7
  private var gageArray:[UIView] = []
  private var topLabelArray:[UILabel] = []
  private var baseArray:[JDVGraphBaseCell] = []
  
  // MARK: UI values
  let offset:CGFloat = 5
  
  
  
  var value:CGFloat{
    return currentValue
  }
 
  
  //once
  func setup() {
    
    for _ in 0..<numberOfRows{
      let gage = UIView()
      gage.backgroundColor = UIColor.lightGray
      gageArray.append(gage)
      
      let label = UILabel()
      label.text = "12"
      label.textAlignment = .center
      label.backgroundColor = UIColor.red
      topLabelArray.append(label)
      
      let base = JDVGraphBaseCell()
      baseArray.append(base)
    }
  }
  
  //when value changes in interface builder
  func configureUI() {
    print("configure")
  }
  
  
  
  
  
  
  //draw when view changes
  
  // MARK: - ui
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let totalWidth = self.size.width
    let totalHeight = self.size.height
    let sumOfWidthOfSpace = CGFloat((numberOfRows-1)) * offset
    let baseSize = CGSize(width: 30, height: 30)
    let gageWidth:CGFloat = 20
    
    let startx = (totalWidth - sumOfWidthOfSpace - baseSize.width * CGFloat(numberOfRows))/2
    
    //Set base Frame
    for (index,base) in baseArray.enumerated(){
      base.frame = CGRect(x: startx + (offset + baseSize.width) * CGFloat(index), y: totalHeight - baseSize.height, width: baseSize.width, height: baseSize.height)
      self.addSubview(base)
      
    }
    
    //Set gage Frame
    for (index,gage) in gageArray.enumerated(){
      let base = baseArray[index]
      
      gage.frame = CGRect(x: base.centerX - gageWidth/2, y: totalHeight - baseSize.height, width: gageWidth, height: -100)
      self.addSubview(gage)
    }
    
    //Set label Frame
    for (index,label) in topLabelArray.enumerated(){
      
      let gage = gageArray[index]
      
      label.frame = CGRect(x: gage.centerX-15, y: gage.y - 32, width: 30, height: 30)
      self.addSubview(label)
    }
    
    
    animateShapeLayer()
    
  }
  
  override func prepareForInterfaceBuilder() {
    setup()
    configureUI()
    layoutSubviews()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
    configureUI()
    
  }
  
  func animateShapeLayer() {
    let gage = self.gageArray[0]
    let label = self.topLabelArray[0]
    UIView.animate(withDuration: 3) { ]
      
      gage.frame = CGRect(x: gage.x, y: self.size.height - 30, width: gage.width, height: -200)
      label.frame = CGRect(x: label.x, y: gage.y - 32, width: 30, height: 30)
    }
    
    
    
  }
  
  
  
}

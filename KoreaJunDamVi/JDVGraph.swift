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
    
    for i in 0..<numberOfRows{
      let base = JDVGraphBaseCell(title: "row\(i)", value: 20)
      baseArray.append(base)
      
      if i % 2 == 0 {
        base.highlight = true
      }
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
    let baseSize = CGSize(width: 40, height: totalHeight)
    
    let startx = (totalWidth - baseSize.width * CGFloat(numberOfRows))/2
    
    //Set base Frame
    for (index,base) in baseArray.enumerated(){
      base.frame = CGRect(x: startx + baseSize.width * CGFloat(index), y: 0 , width: baseSize.width, height: baseSize.height)
      self.addSubview(base)
      
    }
    
    
    
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
    
  }
  
  
  
}

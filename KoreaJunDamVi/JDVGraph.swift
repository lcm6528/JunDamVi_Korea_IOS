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
  private var numberOfRows:Int = 16
  private var dataArray:[JDVGraphCell] = []
  
  var value:CGFloat{
    return currentValue
  }
 
  
  //once
  func setup() {
    
    for _ in 0..<numberOfRows{
      let cell = JDVGraphCell()
      dataArray.append(cell)
    }
    print("numberOfRows : \(dataArray.count)")
  }
  
  //when value changes in interface builder
  func configureUI() {
    print("configure")
  }
  
  
  
  
  
  
  //draw when view changes
  
  // MARK: - ui
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let offset:CGFloat = 15
    let sumOfWidthOfSpace = CGFloat(15 * (numberOfRows-1))
    let totalWidth = self.size.width
    let cellWidth = (CGFloat(15*(2*numberOfRows-1)) > totalWidth) ? (totalWidth - sumOfWidthOfSpace)/CGFloat(numberOfRows) : CGFloat(15)
    
    let startx = (totalWidth - sumOfWidthOfSpace - cellWidth * CGFloat(numberOfRows))/2
    
    for (index,cell) in dataArray.enumerated(){
      cell.frame = CGRect(x: startx + (offset + cellWidth) * CGFloat(index), y: 0, width: cellWidth, height: 50)
      self.addSubview(cell)
    }
    
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
  }
  
  
  
}

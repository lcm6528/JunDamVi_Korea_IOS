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
    private var range: CGFloat = 100
    
    private var baseArray:[JDVGraphBaseCell] = []
    private var dataModel:JDVGraphModel?
    
    private var numberOfCells:Int = 0
    
    
    // MARK: UI values
    
    @IBInspectable var normalGageColor: UIColor = UIColor.lightGray {
        didSet { configureUI() } }
    @IBInspectable var highlightGagecolor: UIColor = UIColor.red {
        didSet { configureUI() } }
    
    @IBInspectable var viewBackgroundColor: UIColor = UIColor.clear
        {didSet
        {
            self.backgroundColor = viewBackgroundColor
        }
    }
    var highlightRange:Int = 0{//setter method를 따로 해야하나?
        didSet{
            configureUI()
        }
    }
    
    
    
    func setData(model val:JDVGraphModel){
        
        dataModel = val
        setup()
        configureUI()
    }
    
    
    
    func setHighlight(toStanding val:Int){
        highlightRange = val
    }
    
    
    //once
    func setup() {
        
        guard dataModel != nil else{return}
        
        for item in dataModel!.Items{
            let base = JDVGraphBaseCell(title: item.title, value: item.value)
            base.highlightGagecolor = highlightGagecolor
            base.normalGageColor = normalGageColor
            
            
            baseArray.append(base)
        }
        
        numberOfCells = baseArray.count
    }
    
    
    //when value changes in interface builder
    func configureUI() {
        
        guard dataModel != nil else{return}
        
        //set UI for Highlight
        for (index,item) in dataModel!.Items.enumerated(){
            
            if item.standings <= highlightRange{
                baseArray[index].setHighlight(Bool:true)
            }
        }
    }
    
    
    //draw when view changes
    
    // MARK: - ui
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let totalWidth = self.size.width
        
        let totalHeight = self.size.height
        
        let baseSize = CGSize(width: totalWidth/CGFloat(numberOfCells), height: totalHeight)
        
        let startx = (totalWidth - baseSize.width * CGFloat(numberOfCells))/2
        
        //Set base Frame
        for (index,base) in baseArray.enumerated(){
            base.frame = CGRect(x: startx + baseSize.width * CGFloat(index), y: 0 , width: baseSize.width, height: baseSize.height)
            self.addSubview(base)
            
        }
        
    }
    
    
    
    override func prepareForInterfaceBuilder() {
        setup()
        layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func animate(withDuration duration:Double){
        
        
        for cell in baseArray{
            cell.duration = duration
            cell.setGageHeight(getHeightConst(withCell: cell), animate: true)
        }
        
    }
    
    func getHeightConst(withCell cell:JDVGraphBaseCell)->CGFloat{
        
        guard dataModel != nil else{return 0.0}
        
        let max = dataModel!.maxValue
        let ratio:Float = cell.currentValue / max
        let const = CGFloat(ratio) * (self.size.height - 55)
        
        return const
        
    }
    
    
    
}

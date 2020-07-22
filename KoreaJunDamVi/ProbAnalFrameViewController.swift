//
//  JDVProbAnalFrameViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 10..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class JDVProbAnalFrameViewController: JDVViewController {
    
    var option: SortedOption = .theme
    var data: [CommentItem] = []
    var selectedIndex: Int = 0 {
        didSet {
            self.update()
        }
    }
    
    @IBOutlet var graph: JDVGraph!
    @IBOutlet var textView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleWithStyle(option.description + " 분석자료")
        self.titleLabel.text = "\(option.description) 출제비중"
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe(sender:)))
        leftGesture.direction = .left
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe(sender:)))
        rightGesture.direction = .right
        self.textView.addGestureRecognizer(leftGesture)
        self.textView.addGestureRecognizer(rightGesture)
        
        loadData()
    }
    
    @objc
    func swipe(sender: UISwipeGestureRecognizer) {
        print(sender.direction)
        if sender.direction == .left {
            if selectedIndex < data.count - 1 {
                self.selectCell(atRow: selectedIndex + 1)
            }
        } else {
            if selectedIndex > 0 {
                self.selectCell(atRow: selectedIndex - 1)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        graph.animate(withDuration: 0.8)
    }
    
    func loadData() {
        self.data = JDVStatisticManager.shared.getAnalData(type: self.option)
        graph.setData(model: JDVGraphModel(arrayLiteral: self.data))
        
        self.collectionView.reloadData()
        self.selectedIndex = 0
    }
    
    func update() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.textView.alpha = 0
        }) { [weak self] (finish) in
            guard let strongSelf = self else { return }
            strongSelf.textView.attributedText = strongSelf.data[strongSelf.selectedIndex].contentAttr
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.textView.alpha = 1
            }
        }
    }
    
    func selectCell(atRow row: Int) {
        let oldIndex = selectedIndex
        let newIndex = row
        
        self.selectedIndex = newIndex
        
        let oldCell = collectionView.cellForItem(at: IndexPath(row: oldIndex, section: 0)) as? AnalHeaderCell
        let newCell = collectionView.cellForItem(at: IndexPath(row: newIndex, section: 0)) as? AnalHeaderCell
        
        oldCell?.isSelected(selected: false)
        newCell?.isSelected(selected: true)
        
        collectionView.selectItem(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension JDVProbAnalFrameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnalHeaderCell
        cell.setData(data: data[row])
        cell.isSelected(selected: row == selectedIndex)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.selectedIndex != indexPath.row else { return }
        collectionView.selectItem(at: IndexPath(row: selectedIndex - 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        self.selectCell(atRow: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
}


class AnalHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    
    func setData(data: CommentItem) {
        self.textLabel.text = data.title
    }
    
    func isSelected(selected: Bool) {
        textLabel.textColor = selected ? .black : .gray
        bottomLine.backgroundColor = selected ? .black : .clear
    }
}

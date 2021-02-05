//
//  ProbPopupView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 12..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class ProbPopupView: UIViewController {
    
    var dataArray:[ProbData] = []
    var selections:[Int] = []
    var isNoted:[Bool] = []
    
    var didSelectHandler: ((Int) -> Void)?
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func dismissButtonAction(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}


extension ProbPopupView:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.didSelectHandler?(indexPath.row)
        dismiss(animated: true, completion: nil)
    }
}

extension ProbPopupView:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProbPopupCell
        
        cell.configure(WithProb: dataArray[indexPath.row].prob, selections: selections[indexPath.row], isNoted: isNoted[indexPath.row])
        cell.label_ProbNum.text = "\(indexPath.row+1)번"
        return cell
        
    }
    
}
extension ProbPopupView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio: CGFloat = UIDevice.current.isIPadOrLandscape ? 8 : 5
        let offset = (view.size.width - (ratio - 1)) / ratio 
        
        return CGSize(width: offset, height: offset * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//
//  ProbTestFrameViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 25..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import WSProgressHUD
import RealmSwift
class ProbTestFrameViewController: JDVViewController {
    
    @IBOutlet var toolBarCenterLabel: UILabel!
    @IBOutlet var toolBarRightButton: UIButton!
    @IBOutlet var toolBarLeftButton: UIButton!
    @IBOutlet var barButton_Star: JDVNoteBarButtonItem!
    @IBOutlet var barButton_title: UIBarButtonItem!
    
    var number_of_pages = 0
    
    var Probs:[Prob] = []
    var result:TestResult!
    var selections:[Int]?
    var pageViewController:UIPageViewController!
    
    var option:JDVProbManager.ProbOption!
    
    override func setTitleWithStyle(_ text: String) {
        
        self.barButton_title.title = text
        self.barButton_title.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.ProbNaviBarTitleFont,
                                                     NSAttributedStringKey.foregroundColor:UIColor.white], for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !Probs.isEmpty{
            number_of_pages = Probs.count
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        if option.sortedOption != .test{
            let desc = option.sortedOption.description
            let str = desc[..<desc.index(desc.startIndex, offsetBy: 2)]
            setTitleWithStyle(option.cacheKey + str + " 문제풀기")
        } else {
            setTitleWithStyle("\(Probs[0].TestNum)회차 문제풀기")
        }
        
        if selections == nil || selections?.isEmpty == true{
            selections = [Int](repeatElement(0, count: Probs.count))
        }
        
        //////PageVC Settings///////
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProbTestPageViewController") as! UIPageViewController
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        let initialContenViewController = self.pageViewAtIndex(0) as! ProbTestInnerViewController
        
        let viewControllers = NSArray(object: initialContenViewController)
        
        
        self.pageViewController.setViewControllers(viewControllers as! [ProbTestInnerViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: self.view.frame.size.height-44)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        //////////////////////
        
        self.navigationController?.delegate = self
        setToolbarTitle(getCurrnetIndexOfPage())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onStop), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
        if option.sortedOption == .test{
            JDVProbManager.saveCachedData(with: "\(Probs[0].TestNum)", tries: selections!)
        } else {
            JDVProbManager.saveCachedData(with: option.cacheKey, tries: selections!)
        }
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func onStop() {
        if option.sortedOption == .test{
            JDVProbManager.saveCachedData(with: "\(Probs[0].TestNum)", tries: selections!)
        } else {
            JDVProbManager.saveCachedData(with: option.sortedOption.rawValue, tries: selections!)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "popup"{
            let vc = segue.destination as! ProbPopupView
            vc.dataArray = Probs
            vc.selections = selections!
            
            vc.isNoted = Probs.map{ prob in
                return JDVNoteManager.isAdded(by: prob.ProbID)
            }
            
            vc.didSelectHandler = { [unowned self] index in
                
                let currentIdx = self.getCurrnetIndexOfPage()
                self.gotoPageAtIndex(currentIdx, goto: index)
                self.setToolbarTitle(currentIdx)
                
            }
        }else if segue.identifier == "push"{
            
            let vc = segue.destination as! ProbResultViewController
            var tries:[Try] = []
            for (index, prob) in Probs.enumerated() {
                let item = Try(withProb: prob, selection: selections![index])
                
                tries.append(item)
            }
            result = TestResult(withTestType: option.sortedOption.rawValue, forKey: option.cacheKey, withTries: tries)
            vc.result = self.result
            vc.option = option
            
            if option.sortedOption == .test{
                JDVScoreManager.configureAnalData(by: result)
            }
            
            let record = TestResultRecord(by: result)
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(record)
            }
            
        }else if segue.identifier == "pushsimple"{
            let vc = segue.destination as! SimpleResultViewController
            var tries:[Try] = []
            for (index, prob) in Probs.enumerated() {
                let item = Try(withProb: prob, selection: selections![index])
                
                tries.append(item)
            }
            result = TestResult(withTestType: option.sortedOption.rawValue, forKey: option.cacheKey, withTries: tries)
            vc.result = self.result
            vc.option = option
            
            
            let record = TestResultRecord(by: result)
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(record)
            }

        }
        
    }
    
    
    @IBAction func noteButtonPressed(_ sender: JDVNoteBarButtonItem) {
        let index = getCurrnetIndexOfPage()
        
        let note = Note()
        note.ProbID = Probs[index].ProbID
        note.Selection = selections![index]
        
        if sender.isSelected == false{
            JDVNoteManager.saveNote(by: note)
        } else {
            JDVNoteManager.deleteNote(by: note)
        }
        
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func popUpList(_ sender: AnyObject) {
        performSegue(withIdentifier: "popup", sender: self)
        
        
    }
    
    @IBAction func completeButtonPressed(_ sender: Any) {
        option.sortedOption == .test ? pushResultVC(withSegue: "push") : pushResultVC(withSegue: "pushsimple")
    }
    
    
    func pushResultVC(withSegue id:String) {
        
        let alert = UIAlertController(title: "풀이완료", message: "문제풀이를 종료하고\n결과를 확인하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "닫기", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { (action) in
            WSProgressHUD.show(withStatus: "체점 중 ..")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.performSegue(withIdentifier: id, sender: self)
                self.navigationController?.popViewController(animated: false)
            })
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func leftBarButtonPressed(_ sender: AnyObject) {
        gotoPrevPage()
    }
    
    
    @IBAction func rightBarButtonPressed(_ sender: AnyObject) {
        
        gotoNextPage()
    }
    
    
    
    
    func setToolbarTitle(_ index:Int) {
        
        let numberOfTest:Int = index+1
        toolBarCenterLabel.text = "\(numberOfTest)번"
        
        barButton_Star.isSelected = JDVNoteManager.isAdded(by: Probs[index].ProbID)
        
        if index == 0{
            toolBarRightButton.setTitle( "\(numberOfTest+1)번", for: .normal)
            toolBarLeftButton.setTitle( "", for: .normal)
        }
        else if index == number_of_pages - 1
        {
            toolBarLeftButton.setTitle( "\(numberOfTest-1)번", for: .normal)
            toolBarRightButton.setTitle( "풀이완료", for: .normal)
        } else {
            toolBarLeftButton.setTitle( "\(numberOfTest-1)번", for: .normal)
            toolBarRightButton.setTitle( "\(numberOfTest+1)번", for: .normal)
        }
        
        
    }
    
    
    
    
    
}

//MARK : PageView Delegate,Datasource
extension ProbTestFrameViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed == true{
            setToolbarTitle(getCurrnetIndexOfPage())
        }
        
    }
    
    func pageViewAtIndex(_ index: Int) ->JDVViewController{
        let innerView = self.storyboard?.instantiateViewController(withIdentifier: "ProbTestInnerViewController") as! ProbTestInnerViewController
        innerView.Prob = Probs[index]
        innerView.pageIndex = index
        innerView.option = option.sortedOption
        innerView.selectHandler = { (num,selection) -> Void in
            self.selections![num] = selection
            self.gotoNextPage()
        }
        if selections![index] != 0 {
            innerView.selection = selections![index]
        }
        return innerView
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ProbTestInnerViewController
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound) {return nil}
        
        index -= 1
        
        return self.pageViewAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ProbTestInnerViewController
        var index = viewController.pageIndex as Int
        if((index == NSNotFound))
        {return nil}
        
        index += 1
        
        if(index == number_of_pages) {return nil}
        
        return self.pageViewAtIndex(index)
    }
    
    
    func gotoPageAtIndex(_ currentIndex:Int , goto index:Int) {
        
        let nextIndex = index
        
        guard nextIndex >= 0 && nextIndex < number_of_pages else {return}
        
        let vc = pageViewAtIndex(nextIndex)
        
        let completion:(Bool)->() = { success in
            self.setToolbarTitle(nextIndex)
        }
        
        if currentIndex > nextIndex{
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: completion)
        } else {
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: completion)
        }
        
    }
    
    
    func gotoNextPage() {
        
        isBlockUserInteract = true
        let nextIndex = getCurrnetIndexOfPage()+1
        if nextIndex == number_of_pages {
            isBlockUserInteract = false
            option.sortedOption == .test ? pushResultVC(withSegue: "push") : pushResultVC(withSegue: "pushsimple")
            
            
        }else if nextIndex < number_of_pages{
            let vc = pageViewAtIndex(nextIndex)
            
            
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: { (completion) in
                
                isBlockUserInteract = false
                self.setToolbarTitle(self.getCurrnetIndexOfPage())
            })
            
        }
        
    }
    
    func gotoPrevPage() {
        isBlockUserInteract = true
        let nextIndex = getCurrnetIndexOfPage()-1
        
        guard nextIndex >= 0 else {return}
        
        let vc = pageViewAtIndex(nextIndex)
        
        pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: { (completion) in
            isBlockUserInteract = false
            self.setToolbarTitle(self.getCurrnetIndexOfPage())
        })
        
    }
    
    
    
    func getCurrnetIndexOfPage()-> Int{
        
        let vc  = pageViewController.viewControllers?.first as! ProbTestInnerViewController
        return vc.pageIndex
        
    }
    
}


extension ProbTestFrameViewController:UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        WSProgressHUD.dismiss()
        isBlockUserInteract = false
        
    }
    
}

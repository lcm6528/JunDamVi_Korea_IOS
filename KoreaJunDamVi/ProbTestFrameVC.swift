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
import Firebase

class ProbTestFrameViewController: JDVViewController {
    
    @IBOutlet var toolBarCenterLabel: UILabel!
    @IBOutlet var toolBarRightButton: UIButton!
    @IBOutlet var toolBarLeftButton: UIButton!
    @IBOutlet var barButton_Star: JDVNoteBarButtonItem!
    @IBOutlet var barButton_title: UIBarButtonItem!
    
    var number_of_pages = 0
    
    var probData: [ProbData] = []
    var result: TestResult!
    var selections: [Int]?
    var pageViewController: UIPageViewController!
    
    var option: JDVProbManager.ProbOption!
    
    override func setTitleWithStyle(_ text: String) {
        self.barButton_title.title = text

        self.barButton_title.setTitleTextAttributes(
            [NSAttributedString.Key.font:UIFont.ProbNaviBarTitleFont,
             NSAttributedString.Key.foregroundColor:UIColor.textBlack0],
            for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !probData.isEmpty {
            number_of_pages = probData.count
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        if option.sortedOption == .test {
            setTitleWithStyle("\(probData[0].prob.TestNum)회차 문제풀기")
        } else if option.sortedOption == .note {
            setTitleWithStyle("오답 노트 문제풀기")
        } else {
            let desc = option.sortedOption.description
            let str = desc[..<desc.index(desc.startIndex, offsetBy: 2)]
            setTitleWithStyle(option.cacheKey + str + " 문제풀기")
        }
        
        if selections == nil || selections?.isEmpty == true {
            selections = [Int](repeatElement(0, count: probData.count))
        }
        
        //////PageVC Settings///////
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProbTestPageViewController") as! UIPageViewController
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        let initialContenViewController = self.pageViewAtIndex(0) as! TempleteVC
        
        let viewControllers = NSArray(object: initialContenViewController)
        
        
        self.pageViewController.setViewControllers(viewControllers as! [TempleteVC], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        if #available(iOS 11.0, *) {
            let height = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height ?? 0
            let inset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            if JDVUserManager.hasTopNotch {
                self.pageViewController.view.frame = CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: height + inset)
            } else {
                self.pageViewController.view.frame = CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: self.view.frame.size.height - 44)
            }
        } else {
            self.pageViewController.view.frame = CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: self.view.frame.size.height - 44)
        }
        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        //////////////////////
        
        self.navigationController?.delegate = self
        setToolbarTitle(getCurrnetIndexOfPage())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(onStop), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
        guard option.sortedOption != .note else { return }
        
        if option.sortedOption == .test {
            JDVProbManager.saveCachedData(with: "\(probData[0].prob.TestNum)", tries: selections!)
        } else {
            JDVProbManager.saveCachedData(with: option.cacheKey, tries: selections!)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onStop() {
        guard option.sortedOption != .note else { return }
        
        if option.sortedOption == .test {
            JDVProbManager.saveCachedData(with: "\(probData[0].prob.TestNum)", tries: selections!)
        } else {
            JDVProbManager.saveCachedData(with: option.sortedOption.rawValue, tries: selections!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popup" {
            let vc = segue.destination as! ProbPopupView
            vc.dataArray = probData
            vc.selections = selections!
            
            vc.isNoted = probData.map { prob in
                return JDVNoteManager.isAdded(by: prob.probID)
            }
            
            vc.didSelectHandler = { [weak self] index in
                let currentIdx = self?.getCurrnetIndexOfPage() ?? 0
                self?.gotoPageAtIndex(currentIdx, goto: index)
                self?.setToolbarTitle(currentIdx)
            }
        } else if segue.identifier == "push" {
            let vc = segue.destination as! ProbResultViewController
            var tries: [Try] = []
            for (index, prob) in probData.enumerated() {
                let item = Try(withProb: prob.prob, selection: selections![index])
                tries.append(item)
            }
            
            result = TestResult(testNum: probData.first?.prob.TestNum ?? 0,TestType: option.sortedOption.rawValue, forKey: option.cacheKey, withTries: tries)
            vc.result = self.result
            vc.option = option
            
            if option.sortedOption == .test {
                JDVScoreManager.configureAnalData(by: result)
            }
            
            let record = TestResultRecord(by: result)
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(record)
            }
            
        } else if segue.identifier == "pushsimple" {
            let vc = segue.destination as! SimpleResultViewController
            var tries: [Try] = []
            for (index, prob) in probData.enumerated() {
                let item = Try(withProb: prob.prob, selection: selections![index])
                tries.append(item)
            }
            result = TestResult(testNum: probData.first?.prob.TestNum ?? 0,TestType: option.sortedOption.rawValue, forKey: option.cacheKey, withTries: tries)
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
        note.ProbID = probData[index].probID
        note.Selection = selections![index]
        
        if sender.isSelected == false {
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
    
    func pushResultVC(withSegue id: String) {
        let alert = UIAlertController(title: "풀이완료", message: "문제풀이를 종료하고\n결과를 확인하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "닫기", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in
            WSProgressHUD.show(withStatus: "채점 중 ..")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                self?.performSegue(withIdentifier: id, sender: self)
                self?.navigationController?.popViewController(animated: false)
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
    
    func setToolbarTitle(_ index: Int) {
        let numberOfTest: Int = index + 1
        barButton_Star.isSelected = JDVNoteManager.isAdded(by: probData[index].probID)
        
        let thisDesc = option.sortedOption == .note ? probData[index].desc : "\(numberOfTest)번"
        
        toolBarCenterLabel.text = thisDesc
        
        if index == 0 {
            let nextDesc = option.sortedOption == .note ? probData[index + 1].desc : "\(numberOfTest + 1)번"
            toolBarRightButton.setTitle(nextDesc, for: .normal)
            toolBarLeftButton.setTitle("" , for: .normal)
        } else if index == number_of_pages - 1 {
            let prevDesc = option.sortedOption == .note ? probData[index - 1].desc : "\(numberOfTest - 1)번"
            
            toolBarLeftButton.setTitle(prevDesc, for: .normal)
            toolBarRightButton.setTitle( "풀이완료", for: .normal)
        } else {
            let nextDesc = option.sortedOption == .note ? probData[index + 1].desc : "\(numberOfTest + 1)번"
            let prevDesc = option.sortedOption == .note ? probData[index - 1].desc : "\(numberOfTest - 1)번"
            
            toolBarLeftButton.setTitle(prevDesc, for: .normal)
            toolBarRightButton.setTitle(nextDesc, for: .normal)
        }
    }
}

//MARK : PageView Delegate,Datasource
extension ProbTestFrameViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed == true {
            setToolbarTitle(getCurrnetIndexOfPage())
        }
    }
    
    func pageViewAtIndex(_ index: Int) -> JDVViewController {
        let innerView = UIStoryboard(name: "Templete", bundle: nil).instantiateViewController(withIdentifier: "TempleteVC") as! TempleteVC
        innerView.probData = probData[index]
        innerView.pageIndex = index
        innerView.templete = TEMPLETE_TEST_NoSolution
        innerView.selection = selections![index]
        innerView.delegate = self
        innerView.templeteOption = self.option.sortedOption.isCurated() ? .CURATED : .TEST
        
        return innerView
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! TempleteVC
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound) { return nil }
        
        index -= 1
        return self.pageViewAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! TempleteVC
        var index = viewController.pageIndex as Int
        if((index == NSNotFound)) { return nil }
        
        index += 1
        
        if(index == number_of_pages) { return nil }
        return self.pageViewAtIndex(index)
    }
    
    func gotoPageAtIndex(_ currentIndex: Int , goto index: Int) {
        let nextIndex = index
        guard nextIndex >= 0 && nextIndex < number_of_pages else { return }
        
        let vc = pageViewAtIndex(nextIndex)
        
        let completion:(Bool) -> () = { [weak self] success in
            self?.setToolbarTitle(nextIndex)
        }
        
        if currentIndex > nextIndex {
            pageViewController.setViewControllers([vc], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: completion)
        } else {
            pageViewController.setViewControllers([vc], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: completion)
        }
        
    }
    
    func gotoNextPage() {
        isBlockUserInteract = true
        let nextIndex = getCurrnetIndexOfPage() + 1
        if nextIndex == number_of_pages {
            isBlockUserInteract = false
            option.sortedOption == .test ? pushResultVC(withSegue: "push") : pushResultVC(withSegue: "pushsimple")
            
        }else if nextIndex < number_of_pages{
            let vc = pageViewAtIndex(nextIndex)
            
            pageViewController.setViewControllers([vc], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: { [weak self] (completion) in
                
                isBlockUserInteract = false
                self?.setToolbarTitle(self?.getCurrnetIndexOfPage() ?? 0)
            })
        }
    }
    
    func gotoPrevPage() {
        isBlockUserInteract = true
        let nextIndex = getCurrnetIndexOfPage() - 1
        
        guard nextIndex >= 0 else {
            isBlockUserInteract = false
            return
        }
        
        let vc = pageViewAtIndex(nextIndex)
        
        pageViewController.setViewControllers([vc], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: { [weak self] (completion) in
            isBlockUserInteract = false
            self?.setToolbarTitle(self?.getCurrnetIndexOfPage() ?? 0)
        })
    }
    
    func getCurrnetIndexOfPage() -> Int {
        let vc  = pageViewController.viewControllers?.first as! TempleteVC
        return vc.pageIndex
    }
}

extension ProbTestFrameViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        WSProgressHUD.dismiss()
        isBlockUserInteract = false
    }
}

extension ProbTestFrameViewController: TempleteDelegate {
    func select(probId: Int, probNum: Int, choice: Int) {
        
        let params: [String: Any] = ["id" : probId,
        "content" : "\(choice)"]
        self.selections![probNum] = choice
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: params)
        ClientLogger.log(log: params.description)
        if self.option.sortedOption == .test {
            JDVProbManager.saveCachedData(with: "\(self.probData[0].prob.TestNum)", tries: self.selections!)
        } else {
            JDVProbManager.saveCachedData(with: self.option.cacheKey, tries: self.selections!)
        }
        if getUserDefaultBoolValue(kAutoNextKey) {
            self.gotoNextPage()
        }
    }
}

//
//  ProbCollectionViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 24..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import WSProgressHUD
import FMDB
import SwiftyJSON
class ProbMenuViewController: JDVViewController ,ProbCollectionViewDelegate{
    
    ////static data
    let kRankingArr = [["조선(24%)","일제강점기(14%)","근대 조선(13%)"],["해석(31%)","암기(20%)","테마(19%)"],["사건(22%)","문화(15%)","제도(12%)"]]
    ////
    
    let kNumber_of_pages = 4
    
    var currentMenu: Int = 0 
    var currentOption = JDVProbManager.ProbOption()
    var pageViewController:UIPageViewController!
    
    let options: [JDVProbManager.SortedOption] = [.test, .time, .type, .theme]
    
    var dataArray: [[String]] = []
    var probData: [ProbData] = []
    var QuickProbs: [QuickProb] = []
    
    var AnalData: JSON!
    
    @IBOutlet var ToolbarButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleWithStyle("기출 문제 풀기")
        fetchList()
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProbMenuPageViewController") as! UIPageViewController
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        let initialContenViewController = self.pageViewAtIndex(0) as! ProbCollectionViewController
        
        let viewControllers = NSArray(object: initialContenViewController)
        
        self.pageViewController.setViewControllers(viewControllers as! [ProbCollectionViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: self.view.frame.size.height-104)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func showIndicator() {
        WSProgressHUD.show(withStatus: "문제 불러오는 중..")
        isBlockUserInteract = true
    }
    
    func ProbCollectionViewSelectedRow(pageindex pIdx: Int, atIndex index: Int) {
        
        let arr = self.dataArray[pIdx]
        currentMenu = pIdx
        currentOption.sortedOption = options[pIdx]
        currentOption.cacheKey = arr[index]
        
        let alert = UIAlertController(title: "문제풀기", message: currentOption.sortedOption.description + " 문제풀기 - " + currentOption.cacheKey, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "처음부터 풀기", style: UIAlertActionStyle.default, handler:
            { action in
                
                self.showIndicator()
                
                JDVProbManager.fetchProbs(withSortedOption: self.currentOption.sortedOption, by: self.currentOption.cacheKey, completion: { [weak self] (probs) in
                    self?.probData = probs
                    self?.performSegue(withIdentifier: "pushinit", sender: self)
                })
        }))
        
        /// if cache data exist
        if let cachedArr = JDVProbManager.getCachedData(with: currentOption.cacheKey) {
            if cachedArr.isEmpty != true{
                alert.addAction(UIAlertAction(title: "이어풀기", style: UIAlertActionStyle.default, handler:
                    { action in
                        self.showIndicator()
                       
                        JDVProbManager.fetchProbs(withSortedOption: self.currentOption.sortedOption, by: self.currentOption.cacheKey, completion: { [weak self] (probs) in
                            self?.probData = probs
                            self?.performSegue(withIdentifier: "pushcont", sender: self)
                        })
                }
                ))
            }
        }
        
        if currentOption.sortedOption == .test {
            alert.addAction(UIAlertAction(title: "빠른채점", style: UIAlertActionStyle.default, handler:
                { action in
                    self.showIndicator()
                    self.QuickProbs = JDVProbManager.fetchQuickProbs(withTestnum: arr[index].toInt()!)
                    self.performSegue(withIdentifier: "quick", sender: self)
            }
            ))
        }
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler:
            { action in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchList() {
        
        var dict: NSDictionary!
        let path = Bundle.main.path(forResource: "ProbList", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        do {
            let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            dict = (object as! NSDictionary)
        } catch { }
        
        for option in options {
            dataArray.append(dict.value(forKey: option.rawValue) as! [String])
        }
        
        let jsondata = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "AnalList", ofType: "json")!))
        AnalData = JSON(data: jsondata)
    }
    
    @IBAction func ToolbarButtonSelected(_ sender: UIButton) {
        guard currentMenu != sender.tag else { return }
        
        currentMenu = sender.tag
        selectButtonInCollection(atIndex: sender.tag)
        gotoPageAtIndex(getCurrnetIndexOfPage(), goto: sender.tag)
    }
    
    func selectButtonInCollection(atIndex index: Int) {
        
        for (idx,button) in ToolbarButtons.enumerated() {
            { ()->Bool in return idx == index}() ? (button.isSelected = true) : (button.isSelected = false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "pushinit":
            let vc = segue.destination as! ProbTestFrameViewController
            vc.probData = self.probData
            vc.option = currentOption
            self.tabBarController?.tabBar.isHidden = true
            
        case "pushcont":
            let vc = segue.destination as! ProbTestFrameViewController
            vc.probData = self.probData
            vc.option = currentOption
            
                
            let savedSelection = JDVProbManager.getCachedData(with: currentOption.cacheKey) ?? []
            var newSelections = [Int](repeatElement(0, count: probData.count))
            if vc.probData.count > savedSelection.count {
                for (i, select) in savedSelection.enumerated() {
                    newSelections[i] = select
                }
                vc.selections = newSelections
            } else {
                vc.selections = savedSelection
            }
            
            self.tabBarController?.tabBar.isHidden = true
            
        case "quick":
            let vc = segue.destination as! ProbQuickTestViewController
            vc.Probs = self.QuickProbs
            vc.option = currentOption
            self.tabBarController?.tabBar.isHidden = true
            
        case "pushanal":
            let vc = segue.destination as! JDVProbAnalFrameViewController
            let key = options[currentMenu].rawValue
            vc.dataObject = AnalData["data"][key].dictionaryObject as! [String : String]
            vc.contentObject = AnalData["content"][key].dictionaryObject as! [String : String]
            vc.option = options[currentMenu]
        default :
            return
        }
        
        self.probData = []
        self.QuickProbs = []
    }
}

extension ProbMenuViewController:UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    //MARK: UIPageViewDelegate,Datasource
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed == true {
            selectButtonInCollection(atIndex: getCurrnetIndexOfPage())
        }
    }
    
    func pageViewAtIndex(_ index: Int) -> JDVViewController {
        if index != 0 {
            let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProbSubCollectionViewController") as! ProbSubCollectionViewController
            
            pageContentViewController.rankingStr = kRankingArr[index - 1]
            pageContentViewController.delegate = self
            pageContentViewController.pageIndex = index
            pageContentViewController.dataArray = self.dataArray[index]
            pageContentViewController.subtitle = options[index].description
            pageContentViewController.pushHandler = { index in
                self.currentMenu = index
                self.performSegue(withIdentifier: "pushanal", sender: self)
            }
            return pageContentViewController
            
        } else {
            let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProbCollectionViewController") as! ProbCollectionViewController
            pageContentViewController.delegate = self
            pageContentViewController.pageIndex = index
            pageContentViewController.dataArray = self.dataArray[index]
            return pageContentViewController
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! ProbCollectionViewController
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound) { return nil }
        index -= 1
        return self.pageViewAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! ProbCollectionViewController
        var index = viewController.pageIndex as Int
        if((index == NSNotFound))
        { return nil }
        
        index += 1
        
        if(index == kNumber_of_pages) { return nil }
        return self.pageViewAtIndex(index)
    }
    
    func gotoPageAtIndex(_ currentIndex: Int , goto index: Int) {
        
        let nextIndex = index
        
        guard nextIndex >= 0 && nextIndex < kNumber_of_pages else { return }
        
        let vc = pageViewAtIndex(nextIndex)
        
        if currentIndex > nextIndex {
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
        } else {
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
    }
    
    func getCurrnetIndexOfPage() -> Int {
        let vc  = pageViewController.viewControllers?.first as! ProbCollectionViewController
        return vc.pageIndex
    }
}

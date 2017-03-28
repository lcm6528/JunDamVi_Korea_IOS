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

class ProbMenuViewController: JDVViewController ,ProbCollectionViewDelegate{
    
    let number_of_pages = 4
    var currentMenu:Int = 0
    var currentOption = JDVProbManager.ProbOption()
    var pageViewController:UIPageViewController!
    
    let options:[JDVProbManager.SortedOption] = [.test,.time,.type,.theme]
    
    var dataArray:[[String]] = []
    
    var Probs:[Prob] = []
    
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
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
        
    }
    func showIndicator(){
        WSProgressHUD.show(withStatus: "문제 불러오는 중..")
        isBlockUserInteract = true
    }
    func ProbCollectionViewSelectedRow(pageindex pIdx:Int, atIndex index: Int) {
        
        let arr = self.dataArray[pIdx]
        currentMenu = pIdx
        currentOption.sortedOption = options[pIdx]
        currentOption.cacheKey = arr[index]
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "처음부터 풀기", style: UIAlertActionStyle.default, handler:
            { action in
                
                self.showIndicator()
                self.Probs = JDVProbManager.fetchProbs(withSortedOption: self.currentOption.sortedOption, by: self.currentOption.cacheKey)
                self.performSegue(withIdentifier: "pushinit", sender: self)
                
        }))
        alert.addAction(UIAlertAction(title: "이어풀기", style: UIAlertActionStyle.default, handler:
            { action in
                self.showIndicator()
                self.Probs = JDVProbManager.fetchProbs(withSortedOption: self.currentOption.sortedOption, by: self.currentOption.cacheKey)
                self.performSegue(withIdentifier: "pushcont", sender: self)
                
        }
        ))
        if currentOption.sortedOption == .test{
            alert.addAction(UIAlertAction(title: "빠른채점", style: UIAlertActionStyle.default, handler:
                { action in
                    self.showIndicator()
                    self.Probs = JDVProbManager.fetchProbs(withTestnum: arr[index].toInt()!)
                    self.performSegue(withIdentifier: "quick", sender: self)
                    
            }
            ))
        }
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler:
            { action in}))
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func fetchList(){
        
        var dict:NSDictionary!
        let path = Bundle.main.path(forResource: "ProbList", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        do {
            let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            dict = object as! NSDictionary
        } catch {}
        
        
        for option in options{
            dataArray.append(dict.value(forKey: option.rawValue) as!  [String])
        }
        
    }
    
    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}
    
    
    @IBAction func ToolbarButtonSelected(_ sender: UIButton) {
        selectButtonInCollection(atIndex: sender.tag)
        gotoPageAtIndex(getCurrnetIndexOfPage(), goto: sender.tag)
        
    }
    
    func selectButtonInCollection(atIndex index:Int){
        
        for (idx,button) in ToolbarButtons.enumerated(){
            {()->Bool in return idx == index}() ? (button.isSelected = true) : (button.isSelected = false)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "pushinit":
            let vc = segue.destination as!ProbTestFrameViewController
            vc.Probs = self.Probs
            vc.option = currentOption
            self.tabBarController?.tabBar.isHidden = true
            
        case "pushcont":
            let vc = segue.destination as!ProbTestFrameViewController
            vc.Probs = self.Probs
            vc.option = currentOption
            
            if options[currentMenu] != .test{
                vc.selections = JDVProbManager.getCachedData(with: currentOption.cacheKey)
            }else{
                vc.selections = JDVProbManager.getCachedData(with: "\(self.Probs[0].TestNum)")
            }
            
            
            self.tabBarController?.tabBar.isHidden = true
            
        case "quick":
            let vc = segue.destination as! ProbQuickTestViewController
            vc.Probs = self.Probs
            
            self.tabBarController?.tabBar.isHidden = true
            
        case "pushanal":
            let vc = segue.destination as! JDVProbAnalFrameViewController
            vc.dataObject = options[currentMenu].description
            
        default :
            return
        }
        
        self.Probs = []
        
        
    }
    
}

extension ProbMenuViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    //MARK: UIPageViewDelegate,Datasource
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed == true{
            selectButtonInCollection(atIndex: getCurrnetIndexOfPage())
        }
        
    }
    
    func pageViewAtIndex(_ index: Int) ->JDVViewController{
        
        
        if index != 0 {
            let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProbSubCollectionViewController") as! ProbSubCollectionViewController
            pageContentViewController.delegate = self
            pageContentViewController.pageIndex = index
            pageContentViewController.dataArray = self.dataArray[index]
            pageContentViewController.subtitle = options[index].description
            pageContentViewController.pushHandler = { index in
                self.currentMenu = index
                self.performSegue(withIdentifier: "pushanal", sender: self)
            }
            return pageContentViewController
            
            
            
        }else{
            
            let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProbCollectionViewController") as! ProbCollectionViewController
            pageContentViewController.delegate = self
            pageContentViewController.pageIndex = index
            pageContentViewController.dataArray = self.dataArray[index]
            return pageContentViewController
            
            
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ProbCollectionViewController
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound){return nil}
        
        index -= 1
        
        return self.pageViewAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ProbCollectionViewController
        var index = viewController.pageIndex as Int
        if((index == NSNotFound))
        {return nil}
        
        index += 1
        
        if(index == number_of_pages){return nil}
        
        return self.pageViewAtIndex(index)
    }
    
    
    
    func gotoPageAtIndex(_ currentIndex:Int , goto index:Int){
        
        let nextIndex = index
        
        guard nextIndex >= 0 && nextIndex < number_of_pages else {return}
        
        let vc = pageViewAtIndex(nextIndex)
        
        if currentIndex > nextIndex{
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
        }else{
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
    }
    
    func getCurrnetIndexOfPage()-> Int{
        
        let vc  = pageViewController.viewControllers?.first as! ProbCollectionViewController
        return vc.pageIndex
        
    }
    
}

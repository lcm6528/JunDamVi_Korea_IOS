//
//  ProbTestFrameViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 25..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import WSProgressHUD
class ProbTestFrameViewController: JDVViewController {
    
    
    
    var number_of_pages = 0
    @IBOutlet var toolBarCenterLabel: UILabel!
    @IBOutlet var toolBarRightButton: UIButton!
    @IBOutlet var toolBarLeftButton: UIButton!
    var pageViewController:UIPageViewController!
    
    
    var Probs:[Prob] = []
    var result:TestResult!
    var selections:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !Probs.isEmpty{
            number_of_pages = Probs.count
        }
        
        
        
        setTitleWithStyle("\(Probs[0].TestNum)회 문제풀기        ")
        selections = [Int](repeatElement(0, count: Probs.count))
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popup"{
            let vc = segue.destination as! ProbPopupView
            vc.dataArray = Probs
            vc.didSelectHandler = { index in
                
                let currentIdx = self.getCurrnetIndexOfPage()
                self.gotoPageAtIndex(currentIdx, goto: index)
                self.setToolbarTitle(currentIdx)
                
            }
        }else if segue.identifier == "push"{
            let vc = segue.destination as! ProbResultViewController
            var tries:[Try] = []
            for (index, prob) in Probs.enumerated(){
                let item = Try(withProb: prob, selection: selections[index])
                tries.append(item)
            }
            result = TestResult(withTries: tries)
            vc.result = self.result
            
        }
        
        
    }
    
    
    @IBAction func popUpList(_ sender: AnyObject) {
//        performSegue(withIdentifier: "popup", sender: self)
        
        pushResultVC()

    }
    
    func pushResultVC(){
        performSegue(withIdentifier: "push", sender: self)
        self.popVC()
    }
    
    @IBAction func leftBarButtonPressed(_ sender: AnyObject) {
        gotoPrevPage()
    }
    
    
    @IBAction func rightBarButtonPressed(_ sender: AnyObject) {
        
        gotoNextPage()
    }
    
    
    func gotoNextPage(){
        
        
        let nextIndex = getCurrnetIndexOfPage()+1
        if nextIndex == number_of_pages {
            pushResultVC()
            
        }else if nextIndex < number_of_pages{
            let vc = pageViewAtIndex(nextIndex)
            
            //      setActiveTools(false)
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: { (completion) in
                //        self.setActiveTools(true)
                self.setToolbarTitle(self.getCurrnetIndexOfPage())
            })
            
            
        }
        
        
        
    }
    
    func gotoPrevPage(){
        
        let nextIndex = getCurrnetIndexOfPage()-1
        
        guard nextIndex >= 0 else {return}
        
        let vc = pageViewAtIndex(nextIndex)
        //    setActiveTools(false)
        pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: { (completion) in
            //      self.setActiveTools(true)
            self.setToolbarTitle(self.getCurrnetIndexOfPage())
        })
        
        
    }
    
    
    
    func setToolbarTitle(_ index:Int){
        
        let numberOfTest:Int = index+1
        toolBarCenterLabel.text = "\(numberOfTest)번"
        if index == 0{
            toolBarRightButton.setTitle( "\(numberOfTest+1)번", for: .normal)
            toolBarLeftButton.setTitle( "", for: .normal)
        }
        else if index == number_of_pages - 1
        {
            toolBarLeftButton.setTitle( "\(numberOfTest-1)번", for: .normal)
            toolBarRightButton.setTitle( "", for: .normal)
        }else{
            toolBarLeftButton.setTitle( "\(numberOfTest-1)번", for: .normal)
            toolBarRightButton.setTitle( "\(numberOfTest+1)번", for: .normal)
        }
        
    }
    
    
    func gotoPageAtIndex(_ currentIndex:Int , goto index:Int){
        
        let nextIndex = index
        
        guard nextIndex >= 0 && nextIndex < number_of_pages else {return}
        
        let vc = pageViewAtIndex(nextIndex)
        
        let completion:(Bool)->() = { success in
            self.setToolbarTitle(nextIndex)
        }
        
        if currentIndex > nextIndex{
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: completion)
        }else{
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: completion)
        }
        
        
    }
    
    func getCurrnetIndexOfPage()-> Int{
        
        let vc  = pageViewController.viewControllers?.first as! ProbTestInnerViewController
        return vc.pageIndex
        
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
        innerView.selectHandler = { (num,selection) -> Void in
            self.selections[num] = selection
            self.gotoNextPage()
        }
        return innerView
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ProbTestInnerViewController
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound){return nil}
        
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
        
        if(index == number_of_pages){return nil}
        
        return self.pageViewAtIndex(index)
    }
}


extension ProbTestFrameViewController:UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        WSProgressHUD.dismiss()
       isBlockUserInteract = false
        
    }
    
    
    
    
}

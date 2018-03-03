//
//  JDVSolutionFrameViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 11..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//
import UIKit
import WSProgressHUD
class JDVSolutionFrameViewController: JDVViewController ,
UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    
    //For test
    var number_of_pages = 0
    ///////////
    
    
    
    @IBOutlet var toolBarCenterLabel: UILabel!
    @IBOutlet var toolBarRightButton: UIButton!
    @IBOutlet var toolBarLeftButton: UIButton!
    
    @IBOutlet var barButton_Star: JDVNoteBarButtonItem!
    
    
    
    var pageViewController:UIPageViewController!
    
    var Probs:[Prob] = []
    var Solvs:[Solution] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setTitleWithStyle("\(Probs[0].TestNum)회 해설")
        if !Probs.isEmpty{
            number_of_pages = Probs.count
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "SolutionPageViewController") as! UIPageViewController
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        let initialContenViewController = self.pageViewAtIndex(0) as! JDVSolutionInnerViewController
        
        let viewControllers = NSArray(object: initialContenViewController)
        
        
        self.pageViewController.setViewControllers(viewControllers as! [JDVSolutionInnerViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: self.view.frame.size.height-44)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        self.navigationController?.delegate = self
        
        setToolbarTitle(getCurrnetIndexOfPage())
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "popup"{
            let vc = segue.destination as! ProbPopupView
            vc.dataArray = Probs
            vc.selections = [Int](repeatElement(1, count: Probs.count))
            vc.isNoted = Probs.map{ prob in
                return JDVNoteManager.isAdded(by: prob.ProbID)
            }
            
            vc.didSelectHandler = { index in
                
                let currentIdx = self.getCurrnetIndexOfPage()
                self.gotoPageAtIndex(currentIdx, goto: index)
                self.setToolbarTitle(currentIdx)
                
            }
            
        }
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func leftBarButtonPressed(_ sender: AnyObject) {
        gotoPrevPage()
    }
    
    
    @IBAction func rightBarButtonPressed(_ sender: AnyObject) {
        
        gotoNextPage()
    }
    
    @IBAction func noteButtonPressed(_ sender: JDVNoteBarButtonItem) {
        let index = getCurrnetIndexOfPage()
        
        let note = Note()
        note.ProbID = Probs[index].ProbID
        note.Selection = 0
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
    
    
    
    
    func gotoNextPage() {
        
        isBlockUserInteract = true
        let nextIndex = getCurrnetIndexOfPage()+1
        if nextIndex == number_of_pages {
            isBlockUserInteract = false
            
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
    
    
    func setToolbarTitle(_ index: Int) {
        
        let numberOfTest: Int = index+1
        toolBarCenterLabel.text = "\(numberOfTest)번"
        
        barButton_Star.isSelected = JDVNoteManager.isAdded(by: Probs[index].ProbID)
        
        if index == 0{
            toolBarRightButton.setTitle( "\(numberOfTest+1)번", for: .normal)
            toolBarLeftButton.setTitle( "", for: .normal)
        }
        else if index == number_of_pages - 1
        {
            toolBarLeftButton.setTitle( "\(numberOfTest-1)번", for: .normal)
            toolBarRightButton.setTitle( "", for: .normal)
        } else {
            toolBarLeftButton.setTitle( "\(numberOfTest-1)번", for: .normal)
            toolBarRightButton.setTitle( "\(numberOfTest+1)번", for: .normal)
        }
        
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed == true{
            
            setToolbarTitle(getCurrnetIndexOfPage())
        }
        
        
    }
    
    func pageViewAtIndex(_ index: Int) ->JDVViewController {
        let innerView = self.storyboard?.instantiateViewController(withIdentifier: "JDVSolutionInnerViewController") as! JDVSolutionInnerViewController
        innerView.pageIndex = index
        innerView.Prob = Probs[index]
        innerView.Solv = Solvs[index]
        
        
        
        return innerView
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! JDVSolutionInnerViewController
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound) {return nil}
        
        index -= 1
        
        return self.pageViewAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! JDVSolutionInnerViewController
        var index = viewController.pageIndex as Int
        if((index == NSNotFound))
        {return nil}
        
        index += 1
        
        if(index == number_of_pages) {return nil}
        
        return self.pageViewAtIndex(index)
    }
    
    
    
    func gotoPageAtIndex(_ currentIndex: Int , goto index: Int) {
        
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
    
    func getCurrnetIndexOfPage()-> Int{
        
        let vc  = pageViewController.viewControllers?.first as! JDVSolutionInnerViewController
        return vc.pageIndex
        
    }
    
    
    
    
}

extension JDVSolutionFrameViewController:UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        WSProgressHUD.dismiss()
        isBlockUserInteract = false
    }
}


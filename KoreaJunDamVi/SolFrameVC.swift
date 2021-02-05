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
    ///
    
    @IBOutlet var toolBarCenterLabel: UILabel!
    @IBOutlet var toolBarRightButton: UIButton!
    @IBOutlet var toolBarLeftButton: UIButton!
    @IBOutlet var barButton_Star: JDVNoteBarButtonItem!
    
    var pageViewController:UIPageViewController!
    
    var probData: [ProbData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitleWithStyle("\(probData[0].prob.TestNum)회 해설")
        if !probData.isEmpty{
            number_of_pages = probData.count
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "SolutionPageViewController") as? UIPageViewController
        
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
        
        self.navigationController?.delegate = self
        
        setToolbarTitle(getCurrnetIndexOfPage())
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popup"{
            let vc = segue.destination as! ProbPopupView
            vc.dataArray = probData
            vc.selections = [Int](repeatElement(1, count: probData.count))
            vc.isNoted = probData.map{ data in
                return JDVNoteManager.isAdded(by: data.probID)
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
        note.ProbID = probData[index].probID
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
            return
        } else if nextIndex < number_of_pages{
            let vc = pageViewAtIndex(nextIndex)
            
            pageViewController.setViewControllers([vc], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: { (completion) in
                
                isBlockUserInteract = false
                self.setToolbarTitle(self.getCurrnetIndexOfPage())
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
        
        pageViewController.setViewControllers([vc], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: { (completion) in
            isBlockUserInteract = false
            self.setToolbarTitle(self.getCurrnetIndexOfPage())
        })
    }
    
    func setToolbarTitle(_ index: Int) {
        let numberOfTest: Int = index+1
        toolBarCenterLabel.text = "\(numberOfTest)번"
        barButton_Star.isSelected = JDVNoteManager.isAdded(by: probData[index].probID)
        
        if index == 0 {
            toolBarRightButton.setTitle( "\(numberOfTest + 1)번", for: .normal)
            toolBarLeftButton.setTitle( "", for: .normal)
        }
        else if index == number_of_pages - 1
        {
            toolBarLeftButton.setTitle( "\(numberOfTest - 1)번", for: .normal)
            toolBarRightButton.setTitle( "", for: .normal)
        } else {
            toolBarLeftButton.setTitle( "\(numberOfTest - 1)번", for: .normal)
            toolBarRightButton.setTitle( "\(numberOfTest + 1)번", for: .normal)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed == true{
            setToolbarTitle(getCurrnetIndexOfPage())
        }
    }
    
    func pageViewAtIndex(_ index: Int) ->JDVViewController {
        let innerView = UIStoryboard(name: "Templete", bundle: nil).instantiateViewController(withIdentifier: "TempleteVC") as! TempleteVC
        innerView.pageIndex = index
        innerView.probData = probData[index]
        innerView.templete = TEMPLETE_Solution
        innerView.templeteOption = .SOLUTION
        
        return innerView
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! TempleteVC
        var index = viewController.pageIndex as Int
        
        if(index == 0 || index == NSNotFound) {return nil}
        index -= 1
        
        return self.pageViewAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! TempleteVC
        var index = viewController.pageIndex as Int
        if((index == NSNotFound))
        { return nil }
        
        index += 1
        if(index == number_of_pages) {return nil}
        
        return self.pageViewAtIndex(index)
    }
    
    
    
    func gotoPageAtIndex(_ currentIndex: Int , goto index: Int) {
        
        let nextIndex = index
        
        guard nextIndex >= 0 && nextIndex < number_of_pages else {return}
        
        let vc = pageViewAtIndex(nextIndex)
        
        let completion: (Bool) -> () = { success in
            self.setToolbarTitle(nextIndex)
        }
        
        if currentIndex > nextIndex {
            pageViewController.setViewControllers([vc], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: completion)
        } else {
            pageViewController.setViewControllers([vc], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: completion)
        }
        
    }
    
    func getCurrnetIndexOfPage()-> Int{
        let vc  = pageViewController.viewControllers?.first as! TempleteVC
        return vc.pageIndex
    }
}

extension JDVSolutionFrameViewController:UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        WSProgressHUD.dismiss()
        isBlockUserInteract = false
    }
}


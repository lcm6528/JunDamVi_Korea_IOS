//
//  NoteFrameVC.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 18/08/2019.
//  Copyright © 2019 JunDamVi. All rights reserved.
//

import UIKit
import WSProgressHUD
import RealmSwift

class NoteFrameVC: JDVViewController {
    
    @IBOutlet var toolBarCenterLabel: UILabel!
    @IBOutlet var toolBarRightButton: UIButton!
    @IBOutlet var toolBarLeftButton: UIButton!
    @IBOutlet var barButton_Star: JDVNoteBarButtonItem!
    @IBOutlet var barButton_title: UIBarButtonItem!
    
    var number_of_pages = 0
    var initialIdx = 0
    var noteDatas: [ProbData] = []
    var pageViewController: UIPageViewController!
    
    var option:JDVProbManager.ProbOption!
    
    override func setTitleWithStyle(_ text: String) {
        
        self.barButton_title.title = text
        
        self.barButton_title.setTitleTextAttributes(
            [NSAttributedStringKey.font:UIFont.ProbNaviBarTitleFont,
             NSAttributedStringKey.foregroundColor:UIColor.white],
            for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleWithStyle("오답노트")
        if !noteDatas.isEmpty {
            number_of_pages = noteDatas.count
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //////PageVC Settings///////
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotePageViewController") as? UIPageViewController
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        let initialContenViewController = self.pageViewAtIndex(initialIdx) as! TempleteVC
        
        let viewControllers = NSArray(object: initialContenViewController)
        
        
        self.pageViewController.setViewControllers(viewControllers as! [TempleteVC], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
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
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        //////////////////////
        
        self.navigationController?.delegate = self
        setToolbarTitle(getCurrnetIndexOfPage())
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func noteButtonPressed(_ sender: JDVNoteBarButtonItem) {
        let index = getCurrnetIndexOfPage()
        let note = noteDatas[index].note

        if sender.isSelected == false {
            JDVNoteManager.saveNote(by: note)
        } else {
            JDVNoteManager.deleteNote(by: note)
        }
        
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func leftBarButtonPressed(_ sender: AnyObject) {
        gotoPrevPage()
    }
    
    
    @IBAction func rightBarButtonPressed(_ sender: AnyObject) {
        gotoNextPage()
    }
    
    func setToolbarTitle(_ index: Int) {
        toolBarCenterLabel.text = noteDatas[index].desc
        
        barButton_Star.isSelected = JDVNoteManager.isAdded(by: noteDatas[index].probID)
        
        if noteDatas.count > 1 {
            if index == 0 {
                toolBarRightButton.setTitle(noteDatas[index + 1].desc, for: .normal)
                toolBarLeftButton.setTitle("" , for: .normal)
            } else if index == number_of_pages - 1 {
                toolBarLeftButton.setTitle( noteDatas[index - 1].desc, for: .normal)
                toolBarRightButton.setTitle( "", for: .normal)
            } else {
                toolBarLeftButton.setTitle(noteDatas[index - 1].desc, for: .normal)
                toolBarRightButton.setTitle(noteDatas[index + 1].desc, for: .normal)
            }
        }
    }
}

//MARK : PageView Delegate,Datasource
extension NoteFrameVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed == true {
            setToolbarTitle(getCurrnetIndexOfPage())
        }
    }
    
    func pageViewAtIndex(_ index: Int) -> JDVViewController {
        let innerView = UIStoryboard(name: "Templete", bundle: nil).instantiateViewController(withIdentifier: "TempleteVC") as! TempleteVC
        innerView.probData = noteDatas[index]
        innerView.pageIndex = index
        innerView.templete = JDVProductManager.isPurchased() ? TEMPLETE_Solution : TEMPLETE_NOTE_NoSolution
        innerView.templeteOption = .NOTE
        
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
        
        let completion:(Bool) -> () = { success in
            self.setToolbarTitle(nextIndex)
        }
        
        if currentIndex > nextIndex {
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: completion)
        } else {
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: completion)
        }
        
    }
    
    func gotoNextPage() {
        isBlockUserInteract = true
        let nextIndex = getCurrnetIndexOfPage() + 1
        
        if nextIndex == number_of_pages {
            isBlockUserInteract = false
            return
        } else if nextIndex < number_of_pages {
            let vc = pageViewAtIndex(nextIndex)
            
            pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: { (completion) in
                
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
        
        pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: { (completion) in
            isBlockUserInteract = false
            self.setToolbarTitle(self.getCurrnetIndexOfPage())
        })
    }
    
    func getCurrnetIndexOfPage() -> Int{
        let vc  = pageViewController.viewControllers?.first as! TempleteVC
        return vc.pageIndex
    }
}

extension NoteFrameVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        WSProgressHUD.dismiss()
        isBlockUserInteract = false
    }
}

//
//  JDVSolutionFrameViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 11..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//
import UIKit

class JDVSolutionFrameViewController: UIViewController ,
UIPageViewControllerDelegate,UIPageViewControllerDataSource {
  
  
  //For test
  let number_of_pages = 3
  ///////////
  
  
  
  @IBOutlet var toolBarCenterLabel: UILabel!
  @IBOutlet var toolBarRightButton: UIButton!
  @IBOutlet var toolBarLeftButton: UIButton!
  var pageViewController:UIPageViewController!
  var currentIndex:Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    
    
    setToolbarTitle(getCurrnetIndexOfPage())
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
      self.performSegue(withIdentifier: "push", sender: self)
      
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
  
  
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
    if completed == true{
      
      setToolbarTitle(getCurrnetIndexOfPage())
    }
    
    
  }
  
  func pageViewAtIndex(_ index: Int) ->JDVViewController{
    let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "JDVSolutionInnerViewController") as! JDVSolutionInnerViewController
    pageContentViewController.pageIndex = index
    return pageContentViewController
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
  {
    let viewController = viewController as! JDVSolutionInnerViewController
    var index = viewController.pageIndex as Int
    
    if(index == 0 || index == NSNotFound){return nil}
    
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
    
    let vc  = pageViewController.viewControllers?.first as! JDVSolutionInnerViewController
    return vc.pageIndex
    
  }
  
  
  
  
}
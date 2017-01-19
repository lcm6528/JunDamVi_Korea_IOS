//
//  ProbCollectionViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 24..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import WSProgressHUD

class ProbMenuViewController: JDVViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource ,ProbCollectionViewDelegate{
  
  let number_of_pages = 4
  var currentMenu:Int = 0
  var pageViewController:UIPageViewController!
  
  @IBOutlet var ToolbarButtons: [UIButton]!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
  
  func ProbCollectionViewSelectedRow(atIndex index: Int) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      
      if index == 2 {
        self.performSegue(withIdentifier: "quick", sender: self)
      }else if index == 1{
        self.performSegue(withIdentifier: "anal", sender: self)
      }else{
        self.performSegue(withIdentifier: "push", sender: self)
      }
     
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
    case "push":
      self.tabBarController?.tabBar.isHidden = true
    case "quick":
      self.tabBarController?.tabBar.isHidden = true
    default :
      return
    }
    
  }
  
  
  
  
  
  
  //MARK: UIPageViewDelegate,Datasource
  
  
  
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
    if completed == true{
      selectButtonInCollection(atIndex: getCurrnetIndexOfPage())
      
    }
    
    
  }
  
  func pageViewAtIndex(_ index: Int) ->JDVViewController{
    let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProbCollectionViewController") as! ProbCollectionViewController
    pageContentViewController.delegate = self
    pageContentViewController.pageIndex = index
    return pageContentViewController
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

  
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

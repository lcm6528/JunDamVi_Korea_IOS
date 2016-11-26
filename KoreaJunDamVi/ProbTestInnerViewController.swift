//
//  ProbTestInnerViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 25..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class ProbTestInnerViewController: JDVViewController {

  
  var parentVC:ProbMenuViewController!
  var pageIndex:Int!
  
  @IBOutlet var testTitleTextView: UITextView!
  @IBOutlet var testContentTextView: UITextView!
  
  
  
  @IBOutlet var testChoice1TextView: UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      testTitleTextView.text = "2. 밑줄 그은 '왕'의 업적으로 옳은 것은?"
      testContentTextView.text = "왕이 이르기를, “양평군 허준은 일찍이 의방을 찬집하라는 선왕의 특명을 받아 몇 년 동안 자료를 수집하였고, 심지어 유배되어 옮겨다니는 가운데서도 그 일을 쉬지 않고 하여 이제 비로소 책으로 엮어 올렸다. 이에 생각건대, 선왕 때 명하신 책이 과인이 계승한 뒤에 완성을 보게 되었으니, 내가 비감한 마음을 금치 못하겠다. 허준에게 말 한 필을 직접 주어 그 공에 보답하고 속히 간행하도록 하라.”라고 하였다.왕이 이르기를, “양평군 허준은 일찍이 의방을 찬집하라는 선왕의 특명을 받아 몇 년 동안 자료를 수집하였고, 심지어 유배되어 옮겨다니는 가운데서도 그 일을 쉬지 않고 하여 이제 비로소 책으로 엮어 올렸다. 이에 생각건대, 선왕 때 명하신 책이 과인이 계승한 뒤에 완성을 보게 되었으니, 내가 비감한 마음을 금치 못하겠다. 허준에게 말 한 필을 직접 주어 그 공에 보답하고 속히 간행하도록 하라.”라고 하였다."
      
      
      testChoice1TextView.text = "왕이 이르기를, “양평군 허준은 일찍이 의방을 찬집하라는 선왕의 특명을 받아 몇 년 동안 자료를 수집하였고, 심지어 유배되어 옮겨다니는 가운데서도 그 일을 쉬지 않고 하여 이제 비로소 책으로 엮어 올렸다. 이에 생각건대, 선왕 때 명하신 책이 과인이 계승한 뒤에 완성을 보게 되었으니, 내가 비감한 마음을 금치 못하겠다. 허준에게 말 한 필을 직접 주어 그 공에 보답하고 속히 간행하도록 하라.”라고 하였다."
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

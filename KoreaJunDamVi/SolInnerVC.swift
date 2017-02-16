//
//  JDVSolutionInnerViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 11..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class JDVSolutionInnerViewController: JDVViewController {
  
  
  var parentVC:ProbMenuViewController!
  var pageIndex:Int!
  
  
  
  
  @IBOutlet var testTitleTextView: UITextView!
  @IBOutlet var testContentTextView: UITextView!
  
  @IBOutlet var testChoiceTextViews: [UITextView]!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    testTitleTextView.text = "2. 밑줄 그은 '왕'의 업적으로 옳은 것은?"
    testContentTextView.text = "왕이 이르기를, “양평군 허준은 일찍이 의방을 찬집하라는 선왕의 특명을 받아 몇 년 동안 자료를 수집하였고, 심지어 유배되어 옮겨다니는 가운데서도 그 일을 쉬지 않고 하여 이제 비로소 책으로 엮어 올렸다. 이에 생각건대, 선왕 때 명하신 책이 과인이 계승한 뒤에 완성을 보게 되었으니, 내가 비감한 마음을 금치 못하겠다. 허준에게 말 한 필을 직접 주어 그 공에 보답하고 속히 간행하도록 하라.”라고 하였다.왕이 이르기를, “양평군 허준은 일찍이 의방을 찬집하라는 선왕의 특명을 받아 몇 년 동안 자료를 수집하였고, 심지어 유배되어 옮겨다니는 가운데서도 그 일을 쉬지 않고 하여 이제 비로소 책으로 엮어 올렸다. 이에 생각건대, 선왕 때 명하신 책이 과인이 계승한 뒤에 완성을 보게 되었으니, 내가 비감한 마음을 금치 못하겠다. 허준에게 말 한 필을 직접 주어 그 공에 보답하고 속히 간행하도록 하라.”라고 하였다."
    
    
    
    setChoices()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setChoices(){
    let arr = ["1. 명과 후금 사이에서 중립 외교를 펼쳤다.","2. 탕평비를 세워 봉당 정치의 폐해를 경계하였다.","3.초계문신제를 시행하여 문신들을 재교육하였다.","4. 6조 직계제를 처음 실시하여 왕권을 강화하였다.","5. 집현전을 설치하여 인재를 육성하고 편찬 사업을 추진하였다."]
    for (index,textView) in testChoiceTextViews.enumerated(){
      textView.text = arr[index]
    }
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


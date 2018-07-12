//
//  JDVBanner.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 7. 15..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit


protocol JDVBannerDelegate{
  func JDVBannerTouched(_ banner:JDVBanner)
}


@IBDesignable class JDVBanner: UIView {
  
  var view:UIView!
  
  
  let NibName: String = "JDVBanner"
  
  @IBOutlet var imageVIew: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var contentLabel: UILabel!
  
  
  var delegate:JDVBannerDelegate?
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    setup()
    
  }
  
  
  required init(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)!
    setup()
  }
  
  func setup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    addSubview(view)
    
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchBanner))
    view.addGestureRecognizer(tap)
    
  }
  
    @objc func touchBanner() {
    
    
    self.delegate?.JDVBannerTouched(self)
  }
  
  
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName:NibName, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
  
  func setBannerForPass(_ type: String) {
    
    if type == "lang"{
      
      imageVIew.image = UIImage(named: "lang_left")
      titleLabel.text = "언어 전체해설 구매하기 15.39$(할인가)"
      contentLabel.text = "메가로스쿨 언어영역 강윤진 강사님의 전 연도 해설"
    }
    else{
      imageVIew.image = UIImage(named: "reas_left")
      titleLabel.text = "추리 전체해설 구매하기 15.39$(할인가)"
      contentLabel.text = "메가로스쿨 추리영역 김재형 강사님의 전 연도 해설"
    }
    
  }
  
  func setBannerForLink(_ type: String, score:Double) {
    
    if type == "lang"{
      
      imageVIew.image = UIImage(named: "lang_left")
      
      switch score {
      case 0..<45:
        titleLabel.text = "괜찮아요! 누구나 겪는 과정입니다."
        contentLabel.text = "급할수록 돌아가라! 기초부터 탄탄히 공부해보는건 어떨까요?\n김윤진 강사의 강의 들으러 가기"
      case 46..<50:
        titleLabel.text = "독해란 결국 정보처리 과정이랍니다."
        contentLabel.text = "나의 정보처리 방식, 어디가 잘못된 것인지 알아볼까요?\n김윤진 강사의 강의 들으러 가기"
      case 51..<55:
        titleLabel.text = "훌륭하네요! 그러나 방심은 금물!"
        contentLabel.text = "주제별 집중 훈련과 선택지 분석으로 언어이해를 완성하세요!\n김윤진 강사의 강의 들으러 가기"
      case 56..<100:
        titleLabel.text = "실수만 안 하면 당신은 이미 변호사!"
        contentLabel.text = "감을 잃지 않도록 경향별 모의고사를 꾸준히 풀어보는 건 어떨까요?\n김윤진 강사의 강의 들으러 가기"
        
      default:
        titleLabel.text = "독해란 결국 정보처리 과정이랍니다."
        contentLabel.text = "나의 정보처리 방식, 어디가 잘못된 것인지 알아볼까요?\n김윤진 강사의 강의 들으러 가기"
      }
      
      
    }
    else{
      imageVIew.image = UIImage(named: "reas_left")
      switch score {
      case 0..<45:
        titleLabel.text = "많이 놀랬죠? 누구나 겪는 과정입니다."
        contentLabel.text = "급할수록 돌아가라! 기초부터 탄탄히 공부해보는건 어떨까요?\n김윤진 강사의 강의 들으러 가기"
      case 46..<50:
        titleLabel.text = "많이 아쉽죠? 조금만 더 하면 올해 로스쿨 갑니다"
        contentLabel.text = "추리논증 37가지 기술을 익힌다면, 고득점도 가능!\n김윤진 강사의 강의 들으러 가기"
      case 51..<55:
        titleLabel.text = "훌륭하네요! 그러나 방심은 금물!"
        contentLabel.text = "기출문제를 완벽히 분석해서 추리논증을 완성하세요!\n김윤진 강사의 강의 들으러 가기"
      case 56..<100:
        titleLabel.text = "실수만 안 하면 당신은 이미 변호사!"
        contentLabel.text = "감을 잃지 않도록 경향별 모의고사를 꾸준히 풀어보는 건 어떨까요?\n김윤진 강사의 강의 들으러 가기"
        
      default:
        titleLabel.text = "실수만 안 하면 당신은 이미 변호사!"
        contentLabel.text = "감을 잃지 않도록 경향별 모의고사를 꾸준히 풀어보는 건 어떨까요?\n김윤진 강사의 강의 들으러 가기"
      }
      
    }
    
  }
  
  
  static func getLink(_ type: String, score:Double)->String{
    
    if type == "lang"{
      
      switch score {
      case 0..<45:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13396#chr_tab"
      case 46..<50:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13442#chr_tab"
      case 51..<55:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13491#chr_tab"
      case 56..<100:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13492#chr_tab"
      default:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13442#chr_tab"
      }
      
      
    }
    else{

      switch score {
      case 0..<45:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13404#chr_tab"
      case 46..<50:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13425#chr_tab"
      case 51..<55:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13516#chr_tab"
      case 56..<100:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13572#chr_tab"
      default:
        return "http://www.megals.co.kr/lecture/lecture_view.asp?chr_cd=13425#chr_tab"
      }
      
    }
  }
  
  
  
  
  
}

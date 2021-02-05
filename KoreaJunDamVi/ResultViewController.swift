//
//  ProbResultViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 12..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
import WSProgressHUD

protocol ProbResultSubViewDelegate {
    func changeView()
}

class ProbResultViewController: UIViewController, ProbResultSubViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var closeNavibar: UIView!
    
    var option: JDVProbManager.ProbOption!
    var result: TestResult!
    var heightOfSubView: CGFloat!
    var addedNote = Set<Note>()
    
    var topView: ProbResultTopView?
    var botView: ProbResultBotView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.text = "\(result.Tries[0].TestNum)회 문제 풀이 결과"
        let realm = try! Realm()
        let trial = Array(realm.objects(TestResultRecord.self)).filter { return $0.TestKey == self.option.cacheKey }.count
        
        result.TryNum = trial
        //topView setup
        self.topView = ProbResultTopView(frame: CGRect.zero)
        topView?.delegate = self
        topView?.configure(result: result)
        
        //botView setup
        self.botView = ProbResultBotView(frame: CGRect.zero)
        botView?.configure(result: result)
        botView?.delegate = self
        botView?.tableView.delegate = self
        botView?.tableView.dataSource = self
        botView?.dismissHandler = {
            self.tabBarController?.selectedIndex = 3
            self.dismiss(animated: true, completion: nil)
        }
        botView?.addNoteHandler = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            let wrongNotes: [Note] = strongSelf.result.Tries
                .filter({ $0.State == .Wrong })
                .map({
                    let note = Note()
                    note.ProbID = $0.ProbID
                    note.Selection = $0.Selection
                    return note
                })
            JDVNoteManager.saveNotes(by: wrongNotes)
            strongSelf.botView?.tableView.reloadDataWithoutScroll()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WSProgressHUD.dismiss()
        JDVProbManager.saveCachedData(with: option.cacheKey, tries: [])
        
        let isLandscape = UIApplication.shared.statusBarOrientation.isLandscape
        
        if let topView = self.topView,
           let botView = self.botView {
            refreshSubviewLayout(isLandscape: UIApplication.shared.statusBarOrientation.isLandscape, size: view.size)
//            stackView.

            stackView.addArrangedSubview(topView)
            stackView.addArrangedSubview(botView)
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        var isLandscape: Bool = false
        
        if size.width > size.height {
            isLandscape = true
        }
        
        refreshSubviewLayout(isLandscape: isLandscape, size: size)
    }
    
    func refreshSubviewLayout(isLandscape: Bool, size: CGSize) {
        
        heightOfSubView = size.height - closeNavibar.height - 20
        
        topView?.snp.updateConstraints({ (make) in
            make.width.equalTo(size.width)
            make.height.equalTo(heightOfSubView * 0.8)
        })
        botView?.snp.updateConstraints({ (make) in
            make.width.equalTo(size.width)
            make.height.equalTo(heightOfSubView)
        })
//        stackView.layoutSubviews()
//        topView?.frame = CGRect(x: 0, y: 0, width: size.width, height: heightOfSubView)
//        botView?.frame = CGRect(x: 0, y: heightOfSubView, width: size.width, height: heightOfSubView)
//
        topView?.refreshLayout(isLandscape: isLandscape)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func changeView() {
//        let offsetY:CGFloat = scrollView.contentOffset.y == 0.0 ? heightOfSubView : 0.0
//        scrollView.setContentOffset(CGPoint(x: 0, y: offsetY) , animated: true)
//        stackView.
    }
    
    @objc func buttonPressed(_ sender:UIButton) {
        
        let tryObj = result.Tries[sender.tag]
        let note = Note()
        note.ProbID = tryObj.ProbID
        note.Selection = tryObj.Selection
        
        if sender.isSelected == false{
            JDVNoteManager.saveNote(by: note)
        } else {
            JDVNoteManager.deleteNote(by: note)
        }
        sender.isSelected = !sender.isSelected
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.Tries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProbResultBotCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProbResultBotCell
        
        cell.configure(item: result.Tries[indexPath.row])
        cell.noteButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        cell.noteButton.tag = indexPath.row
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "testheader")
        let header = view as! testheader
        return header
    }
}

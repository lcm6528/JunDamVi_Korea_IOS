//
//  TempleteVC.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 25/08/2019.
//  Copyright © 2019 JunDamVi. All rights reserved.
//

import UIKit

enum TEMPLETE_OPTION {
    case TEST
    case CURATED
    case NOTE
    case SOLUTION
}

enum TEMPLETE_TYPE {
    
    case PROBLEM
    case CHOICE(index: Int)
    case SOLUTION(index: Int)
    case SHOWAUTH
    case SHOWSOL
    case SEPARATOR
    
    func getResuseIdentifier() -> String {
        switch self {
        case .PROBLEM:
            return "prob"
        case .CHOICE:
            return "choice"
        case .SOLUTION:
            return "solution"
        case .SEPARATOR:
            return "separator"
        case .SHOWAUTH:
            return "showauth"
        case .SHOWSOL:
            return "showsol"
        }
    }
    
    func getIdx() -> Int {
        switch self {
        case .CHOICE(let idx), .SOLUTION(let idx):
            return idx
        default:
            return 0
        }
    }
}

fileprivate let TEMPLETE_SELECTIONS = (0...4).map({ TEMPLETE_TYPE.CHOICE(index: $0)})
fileprivate let TEMPLETE_SOLUTIONS = (0...2).map({ TEMPLETE_TYPE.SOLUTION(index: $0)})

let TEMPLETE_TEST_NoSolution: [TEMPLETE_TYPE] = [TEMPLETE_TYPE.PROBLEM] + TEMPLETE_SELECTIONS + [TEMPLETE_TYPE.SHOWAUTH, TEMPLETE_TYPE.SHOWSOL]
let TEMPLETE_NOTE_NoSolution: [TEMPLETE_TYPE] = [TEMPLETE_TYPE.PROBLEM] + TEMPLETE_SELECTIONS + [TEMPLETE_TYPE.SHOWSOL]

let TEMPLETE_NoSolution: [TEMPLETE_TYPE] = [TEMPLETE_TYPE.PROBLEM] + TEMPLETE_SELECTIONS
let TEMPLETE_Solution: [TEMPLETE_TYPE] = [TEMPLETE_TYPE.PROBLEM] + TEMPLETE_SELECTIONS + [TEMPLETE_TYPE.SEPARATOR] + TEMPLETE_SOLUTIONS

public let SHOW_SOL_KEY = "SHOWSOL"

class TempleteVC: JDVViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var templete: [TEMPLETE_TYPE] = []
    var templeteOption: TEMPLETE_OPTION = .TEST
    
    var probData: ProbData!
    var pageIndex: Int!
    var selection = 0
    var selectHandler:((Int, Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func showSol() {
        //check buy
        if JDVProductManager.isPurchased() {
            //showsol버튼 삭제, sepa 추가, sols 추가
            self.templete.removeLast()
            self.templete.append(TEMPLETE_TYPE.SEPARATOR)
            self.templete += TEMPLETE_SOLUTIONS
            
            self.tableView.reloadDataWithoutScroll()
        } else {
            showAlertWithSelect("해설 구매", message: "한국사 비법노트 해설\n(₩4,900)을 구매합니다.\n이미 구매하셨을 경우, 추가 결제는 진행되지 않습니다", sender: self, handler: { (_) in
                JDVProductManager.Purchase { (success) in
                    if success {
                        self.showSol()
                    }
                }
            })
        }
    }
}

extension TempleteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let item = templete[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: item.getResuseIdentifier(), for: indexPath) as! TempleteCell
        cell.configure(data: probData, idx: item.getIdx(), option: templeteOption)
        
        if case .SHOWSOL = item, let showSolCell = cell as? ShowSolCell {
            showSolCell.button.addTarget(self, action: #selector(TempleteVC.showSol), for: .touchUpInside)
        }
        
        if case .CHOICE(let idx) = item, let selectCell = cell as? SelectionCell {
            if templeteOption == .SOLUTION {
                if probData.answer == idx {
                    selectCell.setState(state: .AUTH)
                } else {
                    selectCell.setState(state: .NONE)
                }
                
            } else if templeteOption == .NOTE {
                if probData.answer == idx {
                    selectCell.setState(state: .AUTH)
                } else if probData.selection != 0 && probData.selection - 1 == idx {
                    selectCell.setState(state: .NOTE_SELECTED)
                } else {
                    selectCell.setState(state: .NONE)
                }
                
            } else if templeteOption == .TEST {
                if selection != 0 && selection - 1 == idx {
                    selectCell.setState(state: .SELECTED)
                } else {
                    selectCell.setState(state: .NONE)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templete.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let item = templete[index]
        
        if case .CHOICE(let idx) = item {
            selectHandler?(self.pageIndex, idx + 1)
        }
    }
}

class SeparatorCell: UITableViewCell, TempleteCell {
    func configure(data: ProbData, idx: Int, option: TEMPLETE_OPTION) {
    }
}

extension UITableView {
    func reloadDataWithoutScroll() {
        let offset = contentOffset
        reloadData()
        layoutIfNeeded()
        setContentOffset(offset, animated: false)
    }
}

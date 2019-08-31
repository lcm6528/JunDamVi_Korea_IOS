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
    case BUTTONS
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
        case .BUTTONS:
            return "buttons"
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

let TEMPLETE_NoSolution: [TEMPLETE_TYPE] = [TEMPLETE_TYPE.PROBLEM] + TEMPLETE_SELECTIONS
let TEMPLETE_Solution: [TEMPLETE_TYPE] = [TEMPLETE_TYPE.PROBLEM] + TEMPLETE_SELECTIONS + TEMPLETE_SOLUTIONS

class TempleteVC: JDVViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var templete: [TEMPLETE_TYPE] = []
    var templeteOption: TEMPLETE_OPTION = .TEST
    
    var probData: ProbData!
    var pageIndex: Int!
    var selection = 0
    var selectHandler:((Int,Int)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension TempleteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let item = templete[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: item.getResuseIdentifier(), for: indexPath) as! TempleteCell
        cell.configure(data: probData, idx: item.getIdx(), option: templeteOption)
        
        if case .CHOICE(let idx) = item, let selectCell = cell as? SelectionCell {
            if templeteOption == .SOLUTION {
                if probData.answer == idx {
                    selectCell.setState(state: .AUTH)
                } else {
                    selectCell.setState(state: .NONE)
                }
                
            } else if templeteOption == .NOTE {
                if probData.selection != 0 && probData.selection - 1 == idx {
                    selectCell.setState(state: .NOTE_SELECTED)
                } else if probData.answer == idx {
                    selectCell.setState(state: .AUTH)
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
}

class SeparatorCell: UITableViewCell, TempleteCell {
    func configure(data: ProbData, idx: Int, option: TEMPLETE_OPTION) {
    }
}

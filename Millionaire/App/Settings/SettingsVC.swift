//
//  SettingsVC.swift
//  Millionaire
//
//  Created by Алексей Сигай on 05/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import UIKit

enum QuestionsOrder {
    case questionsInRow
    case questionsShuffle
}

class SettingsVC: UIViewController {
    
//    /// Замыкание для передачи даных о типе игры
//    var onGameEnd: ((GameType) -> Void)?

    @IBOutlet weak var GameTypeSegmentedControl: UISegmentedControl!
    
    private var selectedGameType: QuestionsOrder {
        switch self.GameTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            return .questionsInRow
        case 1:
            return .questionsShuffle
        default:
            return .questionsInRow
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        Game.shared.questionsOrder = self.selectedGameType
        print("QuestionsOrder: \(Game.shared.questionsOrder)")
    }
}

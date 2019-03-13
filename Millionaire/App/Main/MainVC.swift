//
//  MainVC.swift
//  Millionaire
//
//  Created by Алексей Сигай on 01/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func gameButton(_ sender: Any) {
    }
    
    @IBAction func resultButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "startGameSegue":
            guard let destination = segue.destination as? GameVC else { return }
            destination.onGameEnd = { [weak self] result in
                guard let self = self else { return }
                self.result = result
                print("Последний результат: \(self.result)")
            }
        default:
            break
        }
    }
}

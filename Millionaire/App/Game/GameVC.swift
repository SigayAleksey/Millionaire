//
//  GameVC.swift
//  Millionaire
//
//  Created by Алексей Сигай on 01/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import UIKit

final class GameVC: UIViewController {
    
    /// Замыкание для передачи даных о выигрыше
    var onGameEnd: ((Int) -> Void)?

    // Отображение текущего состояния игры
    @IBOutlet weak var numberOfQuestion: UILabel!
    @IBOutlet weak var gameProgress: UILabel!
    
    @IBOutlet weak var questionText: UITextView!
    
    @IBOutlet weak var answerAButtonObj: UIButton!
    @IBOutlet weak var answerBButtonObj: UIButton!
    @IBOutlet weak var answerCButtonObj: UIButton!
    @IBOutlet weak var answerDButtonObj: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Game.shared.startNewGame()
        
        guard let nextQuestion = Game.shared.gameSession?.questionCounter else { return }
        showQuestion(number: nextQuestion)
        
        Game.shared.gameSession?.fdQuestion.addObserver(self, options: [.new, .initial]) { [weak self] (newValue, _) in
            self?.numberOfQuestion.text = "Вопрос \(newValue)"
        }
        Game.shared.gameSession?.fdProgress.addObserver(self, options: [.new, .initial]) { [weak self] (newValue, _) in
            self?.gameProgress.text = "\(newValue) %"
        }
    }
    
    @IBAction func takeMoney(_ sender: Any) {
        let result = Game.shared.gameSession?.takeMoney()
        showAlert(title: result!.title, message: result!.message)
    }
    
    @IBAction func answerAButton(_ sender: Any) {
        responseProcessing(button: 1)
    }
    @IBAction func answerBButton(_ sender: Any) {
        responseProcessing(button: 2)
    }
    @IBAction func answerCButton(_ sender: Any) {
        responseProcessing(button: 3)
    }
    @IBAction func answerDButton(_ sender: Any) {
        responseProcessing(button: 4)
    }
    
    /// Заполениние UI новым вопросом и вариантами ответов
    private func showQuestion(number: Int) {
        questionText.text = Game.shared.gameSession?.questionsList[number].question
        answerAButtonObj.setTitle(Game.shared.gameSession?.questionsList[number].answerA, for: .normal)
        answerBButtonObj.setTitle(Game.shared.gameSession?.questionsList[number].answerB, for: .normal)
        answerCButtonObj.setTitle(Game.shared.gameSession?.questionsList[number].answerC, for: .normal)
        answerDButtonObj.setTitle(Game.shared.gameSession?.questionsList[number].answerD, for: .normal)
    }
    
    /// Обработка ответа после нажатия на answerXButton
    private func responseProcessing(button number: Int) {
        if let result = Game.shared.gameSession?.responseProcessing(button: number) {
            showAlert(title: result.title, message: result.message)
        } else {
            guard let nextQuestion = Game.shared.gameSession?.questionCounter else { return }
            showQuestion(number: nextQuestion)
        }
    }

    /// Вывод информации о причине завершения игры
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.goToMainScreen()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    /// Завершение игровой сессии и переход на главный экран
    @objc private func goToMainScreen() {
        guard let winningAmount = Game.shared.gameSession?.winningAmount else { return }
        self.onGameEnd?(winningAmount)
        
        let resultOfGame = ResultOfGame(date: Date(), winning: winningAmount)
        if resultOfGame.winning != 0 {
            Game.shared.addResultOfGame(resultOfGame)
        }
        Game.shared.stopGame()
        
        self.navigationController?.popViewController(animated: true)
    }

}

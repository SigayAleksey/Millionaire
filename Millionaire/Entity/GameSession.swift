//
//  GameSession.swift
//  Millionaire
//
//  Created by Алексей Сигай on 01/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import Foundation

enum ResultOfMove {
    case nextStep
    case winning
    case losing
}

class GameSession {
    
    let questionsList: [Question]
    let rate: [Int]
    var questionCounter: Int
    var winningAmount: Int {
        return rate[questionCounter]
    }
    var fdQuestion: Observable<Int> = Observable(1)
//    {
//        return Observable(questionCounter + 1)
//    }
    var fdProgress: Observable<Int> = Observable(0)
//    {
//        return Observable(Int((questionCounter + 1) / (rate.count - 1)) * 100)
//    }

    init(with questionsOrderStrategy: QuestionsOrderStrategy) {
        self.questionsList = questionsOrderStrategy.chooseSequenceOfQuestions(from: Questions.questionsList())
        self.rate = [0, 1_000, 50_000, 200_000, 500_000, 1_000_000]
        self.questionCounter = 0
    }
    
    /// Обработка ответа после нажатия на answerXButton
    func responseProcessing(button number: Int) -> EndGameInformation? {
        if number == questionsList[questionCounter].rightAnswer {
            if questionCounter == questionsList.count - 1 {
                changeCounters(for: .winning)
                return EndGameInformation(
                    title: "Поздравляем!",
                    message: "Вы выиграли миллион!!!")
            } else {
                changeCounters(for: .nextStep)
                return nil
            }
        } else {
            changeCounters(for: .losing)
            return EndGameInformation(
                title: "Ваш ответ неверный",
                message: "Игра окончена")
        }
    }
    
    /// Обновление счетчиков игры в зависимости от результата хода
    private func changeCounters(for result: ResultOfMove) {
        switch result {
        case .nextStep:
            questionCounter += 1
            fdQuestion.value += 1
            fdProgress.value = Int(questionCounter * 100 / (rate.count - 1))
        case .winning:
            questionCounter += 1
            fdProgress.value = Int(questionCounter * 100 / (rate.count - 1))
        case .losing:
            questionCounter = 0
            fdQuestion.value = 0
            fdProgress.value = 0
        }
    }
    
    /// Обработка решения забрать деньги
    func takeMoney() -> EndGameInformation {
        return EndGameInformation(
            title: "Игра окончена!",
            message: "Ваш выигрыш: \(winningAmount)!!!")
    }
}

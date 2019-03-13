//
//  QuestionsShuffleStrategy.swift
//  Millionaire
//
//  Created by Алексей Сигай on 06/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import Foundation

final class QuestionsShuffleStrategy: QuestionsOrderStrategy {
    
    func chooseSequenceOfQuestions(from questions: [Question]) -> [Question] {
        let questionList = Questions.questionsList().shuffled()
        return questionList
    }
}

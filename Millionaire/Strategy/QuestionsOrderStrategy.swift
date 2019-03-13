//
//  QuestionsOrderStrategy.swift
//  Millionaire
//
//  Created by Алексей Сигай on 06/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import UIKit

protocol QuestionsOrderStrategy: AnyObject {
    
    func chooseSequenceOfQuestions(from questions: [Question]) -> [Question]
}

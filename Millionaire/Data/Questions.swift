//
//  Questions.swift
//  Millionaire
//
//  Created by Алексей Сигай on 09/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import Foundation

struct Questions {
    
    static func questionsList() -> [Question] {
        return [Question(question: "Сколько столиц в России?", answerA: "0", answerB: "1", answerC: "2", answerD: "4", rightAnswer: 2),
                Question(question: "В каком году родился Пушкин?", answerA: "1802", answerB: "1786", answerC: "1799", answerD: "1854", rightAnswer: 3),
                Question(question: "Как звали последнего императора Китая?", answerA: "Ху Джи", answerB: "То Ян", answerC: "Ян Ли", answerD: "Пу И", rightAnswer: 4),
                Question(question: "В каком году остовано государство Оман?", answerA: "806 до Н.Э.", answerB: "1209", answerC: "1970", answerD: "1802", rightAnswer: 3),
                Question(question: "Какова глубина Мариинской впадины?", answerA: "5 354 м", answerB: "6 459 м", answerC: "9 654 м", answerD: "10 994 м", rightAnswer: 4),]
    }
}

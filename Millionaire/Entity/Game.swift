//
//  Game.swift
//  Millionaire
//
//  Created by Алексей Сигай on 01/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import Foundation

final class Game {
    static let shared = Game()
    
    private(set) var gameSession: GameSession?
    
    private let ​resultsCaretaker​ = ​ResultsCaretaker​()
    
    private(set) var resultsOfGames: [ResultOfGame] = [] {
        didSet {
            try? self.​resultsCaretaker​.saveResults(self.resultsOfGames)
        }
    }

    var questionsOrder: QuestionsOrder
    
    private init () {
        self.resultsOfGames = (try? self.​resultsCaretaker​.loadResults()) ?? []
        self.questionsOrder = .questionsInRow
    }
    
    func startNewGame() {
        switch Game.shared.questionsOrder {
        case .questionsInRow:
            self.gameSession = GameSession(with: QuestionsInRowStrategy())
        case .questionsShuffle:
            self.gameSession = GameSession(with: QuestionsShuffleStrategy())
        }
    }
    
    func stopGame() {
        self.gameSession = nil
    }

    func addResultOfGame(_ result: ResultOfGame) {
        self.resultsOfGames.append(result)
    }
}

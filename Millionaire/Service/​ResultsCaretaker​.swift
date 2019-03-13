//
//  ​​ResultsCaretaker​​.swift
//  Millionaire
//
//  Created by Алексей Сигай on 05/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import Foundation

final class ​ResultsCaretaker​ {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let resultKey = "result"
    
    func saveResults(_ results: [ResultOfGame]) throws {
        let data = try self.encoder.encode(results)
        UserDefaults.standard.set(data, forKey: self.resultKey)
    }
    
    func loadResults() throws -> [ResultOfGame] {
        guard let data = UserDefaults.standard.data(forKey: self.resultKey) else {
            return []
        }
        return try self.decoder.decode([ResultOfGame].self, from: data)
    }
}

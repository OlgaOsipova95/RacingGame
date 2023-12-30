//
//  StorageScores.swift
//  Racing
//
//  Created by Olga on 30.12.2023.
//

import Foundation

class StorageScores {
    private static let key = "ScoresKey"
    static func getScores() -> [Score] {
        UserDefaults.standard.get([Score].self, forKey: key) ?? []
    }
    static func addScore(score: Score) {
        var scores = getScores()
        scores.append(score)
        UserDefaults.standard.set(scores, forKey: key)
    }
}

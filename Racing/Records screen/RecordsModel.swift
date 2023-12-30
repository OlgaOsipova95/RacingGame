//
//  RecordsModel.swift
//  Racing
//
//  Created by Olga on 30.12.2023.
//

import Foundation

final class RecordsModel {
    var scores: [Score]
    init() {
        self.scores = StorageScores.getScores().sorted(by: { $0.score > $1.score  })
    }
    func getCellsCount() -> Int {
        scores.count
    }
    func getCellData(index: Int) -> Score {
        scores[index]
    }
}

//
//  Score.swift
//  Racing
//
//  Created by Olga on 29.12.2023.
//

import Foundation

struct Score: Codable {
    var gameSettings: GameSettings
    var score: Int
    var date: Date
}

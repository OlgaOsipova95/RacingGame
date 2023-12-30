//
//  GameModel.swift
//  Racing
//
//  Created by Olga on 25.12.2023.
//

import Foundation

final class GameModel {
    private var gameSettings: GameSettings
    var score: Int = 0
    private var obstacles: [Obstacle] = []
    var typeObstacle: GameSettings.TypeObstacles {
        get {
            gameSettings.typeObstacles
        }
    }
    var level: GameSettings.Level {
        get {
            gameSettings.level
        }
    }
    var carColor: GameSettings.ColorsCar {
        get {
            gameSettings.carColor
        }
    }
    var control: GameSettings.Control {
        get {
            gameSettings.control
        }
    }
    init() {
        self.gameSettings = GameSettings.fromUD(userDefaults: UserDefaults.standard)
    }
    
    func addObstacle(obstacle: Obstacle) {
        obstacles.append(obstacle)
    }
    func getObstacles() -> [Obstacle] {
        obstacles
    }
    func deleteObstacle(obstacle: Obstacle) {
        guard let index = obstacles.firstIndex(where: { $0 === obstacle }) else { return }
        obstacles.remove(at: index)
    }
    func deleteAllObstacles() {
        obstacles.removeAll()
    }
    func saveScore() {
        StorageScores.addScore(score: Score(gameSettings: gameSettings, score: score, date: Date()))
    }
}

enum RoadLane {
    case left
    case right
}

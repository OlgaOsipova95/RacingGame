//
//  GamePresenter.swift
//  Racing
//
//  Created by Olga on 25.12.2023.
//

import Foundation
import UIKit

protocol GamePresenterProtocol: AnyObject {
    var delegate: IGameViewDelegate? { get set }
    func createCarController(view: UIView)
    func getAnimationSpeed() -> Double
    func removeObstacle(obstacle: Obstacle)
    func checkCollision()
    func startGame()
    func endGame()
}
protocol IGameViewDelegate: AnyObject {
    func addObstacleOnRoad(obstacle: Obstacle, roadLane: RoadLane)
    func addPlayerOnRoad(player: Player, roadLane: RoadLane)
    func showGameOver(score: String)
    func showScore(score: String)
    
}
final class GamePresenter: GamePresenterProtocol {
    weak var delegate: IGameViewDelegate?
    let model = GameModel()
    var player: Player?
    private var carController: CarControl?
    private var obstaclesTimer: Timer?
    private var collisionTimer: Timer?
    private var scoreTimer: Timer?
    
    deinit {
        NSLog("GamePresenter> deinit")
    }
    
    func createCarController(view: UIView) {
        carController = CarControlCreator.create(type: model.control, view: view)
        carController?.delegate = self
    }
    func startGame() {
        model.score = 0
        delegate?.showScore(score: "\(model.score)")
        self.generatePlayer()
        carController?.start()
        obstaclesTimer = Timer.scheduledTimer(withTimeInterval: getGenerateObstaclesInterval(), repeats: true, block: { [weak self] _ in
            self?.generateObstacle()
        })
        collisionTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: { [weak self]_ in
            self?.checkCollision()
        })
        scoreTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.model.score += 1
            self.delegate?.showScore(score: "\(self.model.score)")
        })
        DispatchQueue.main.async {
            self.generateObstacle()
        }
    }
    
    func endGame() {
        model.saveScore()
        player?.removeView()
        model.getObstacles().forEach({
            $0.stopAnimation()
            $0.removeFromRoad()
        })
        model.deleteAllObstacles()
        carController?.stop()
        delegate?.showGameOver(score: "\(model.score)")
        obstaclesTimer?.invalidate()
        obstaclesTimer = nil
        collisionTimer?.invalidate()
        collisionTimer = nil
        scoreTimer?.invalidate()
        scoreTimer = nil
    }
    func generateObstacle() {
        let randomInt = Int.random(in: 1...2)
        let roadLane = randomInt == 1 ? RoadLane.left : RoadLane.right
        let obstacle = Obstacle(type: model.typeObstacle)
        delegate?.addObstacleOnRoad(obstacle: obstacle, roadLane: roadLane)
        model.addObstacle(obstacle: obstacle)
    }
    func generatePlayer() {
        let randomInt = Int.random(in: 1...2)
        let roadLane = randomInt == 1 ? RoadLane.left : RoadLane.right
        let player = Player(color: model.carColor)
        delegate?.addPlayerOnRoad(player: player, roadLane: roadLane)
        self.player = player
    }
    func removeObstacle(obstacle: Obstacle) {
        model.deleteObstacle(obstacle: obstacle)
    }
    func checkCollision() {
        guard let player = self.player else { return }
        for obstacle in self.model.getObstacles() {
            if obstacle.checkingForCollisions(objectOnRoad: player.carFrame) {
                self.endGame()
                return
            }
        }
    }
    func getAnimationSpeed() -> Double {
        switch model.level {
        case .easy:
            return Constants.animationSpeedEasy
        case .medium:
            return Constants.animationSpeedMedium
        case .hard:
            return Constants.animationSpeedHard
        }
    }
    private func getGenerateObstaclesInterval() -> Double {
        var interval = getAnimationSpeed()
        switch model.level {
        case .easy:
            break
        case .medium:
            interval -= 0.5
        case .hard:
            interval -= 1.0
        }
        return interval
    }
}

extension GamePresenter: CarControlDelegate {
    func onMoveLeft() {
        player?.moveLeft()
    }
    func onMoveRight() {
        player?.moveRight()
    }
}

//
//  Obstacle.swift
//  Racing
//
//  Created by Olga on 05.12.2023.
//

import Foundation
import UIKit

protocol AnimationObstacle {
    func addOnRoad(viewRoad: UIView, roadLane: UILayoutGuide)
    func removeFromRoad()
    func startAnimation(animationSpeed: Double, didEndAnimation: @escaping () -> Void)
    func stopAnimation()
    func checkingForCollisions(objectOnRoad: CGRect) -> Bool
}

class Obstacle {
    private var typeObstacle: GameSettings.TypeObstacles
    private var viewRoad: UIView?
    private lazy var obstacleView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    init(type: GameSettings.TypeObstacles) {
        self.typeObstacle = type
    }
    
    private func setTypeObstacle(type: GameSettings.TypeObstacles) {
        switch type {
        case .tree:
            obstacleView.image = UIImage(named: "tree")
        case .bush:
            obstacleView.image = UIImage(named: "stone")
        }
    }
}

extension Obstacle: AnimationObstacle {
    func addOnRoad(viewRoad: UIView, roadLane: UILayoutGuide) {
        self.viewRoad = viewRoad
        let width = roadLane.layoutFrame.width*0.75
        let size = CGSize(width: width, height: width)
        let origin = CGPoint(x: roadLane.layoutFrame.midX-size.width/2, y: 0)
        setTypeObstacle(type: typeObstacle)
        obstacleView.frame = CGRect(origin: origin, size: size)
        viewRoad.addSubview(obstacleView)
    }
    func removeFromRoad() {
        obstacleView.removeFromSuperview()
    }
    func startAnimation(animationSpeed: Double, didEndAnimation: @escaping () -> Void) {
        guard let viewRoad = viewRoad else { return }
        UIView.animate(withDuration: animationSpeed, delay: 0, options: [.curveLinear]) {
            self.obstacleView.frame.origin.y += viewRoad.frame.height
        } completion: { _ in
            didEndAnimation()
        }
    }
    func stopAnimation() {
        obstacleView.layer.removeAllAnimations()
    }
    func checkingForCollisions(objectOnRoad: CGRect) -> Bool {
        guard let presentation = obstacleView.layer.presentation() else { return false }
        return presentation.frame.intersects(objectOnRoad)
    }
}

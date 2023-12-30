//
//  Player.swift
//  Racing
//
//  Created by Olga on 30.11.2023.
//

import Foundation
import UIKit

protocol MovingPlayer {
    func moveLeft()
    func moveRight()
    var carFrame: CGRect { get }
}

class Player: MovingPlayer {
    private var color: GameSettings.ColorsCar
    var carFrame: CGRect {
        guard let presentation = car.layer.presentation() else { return .zero }
        return presentation.frame
    }
    private var viewRoad: UIView?
    private lazy var car: UIImageView = {
        let image = UIImage(named: "car")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    init(color: GameSettings.ColorsCar) {
        self.color = color
    }

    func addPlayerOnRoad(viewRoad: UIView, direction: UILayoutGuide) {
        self.viewRoad = viewRoad
        let size = CGSize(width: direction.layoutFrame.width*0.5, height: direction.layoutFrame.width)
        let origin = CGPoint(x: direction.layoutFrame.midX - size.width/2, y: direction.layoutFrame.maxY-size.height)
        car.frame = CGRect(origin: origin, size: size)
        setColor(color: color)
        viewRoad.addSubview(car)
    }
    
    func moveLeft() {
        guard let viewRoad = viewRoad else { return }
        if self.car.frame.midX > viewRoad.bounds.midX {
            UIView.animate(withDuration: Constants.animationSpeed) {
                self.car.frame.origin.x -= viewRoad.frame.width/2
            }
        }
    }
    
    func moveRight() {
        guard let viewRoad = viewRoad else { return }
        if self.car.frame.midX < viewRoad.bounds.midX {
            UIView.animate(withDuration: Constants.animationSpeed) {
                self.car.frame.origin.x += viewRoad.frame.width/2
            }
        }
    }
    func removeView() {
        car.removeFromSuperview()
    }
    func setColor(color: GameSettings.ColorsCar) {
        switch color{
        case .blue:
            car.tintColor = .blue
        case .red:
            car.tintColor = .red
        case .green:
            car.tintColor = .green
        }
    }
}

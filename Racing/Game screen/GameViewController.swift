//
//  GameViewController.swift
//  Racing
//
//  Created by Olga on 30.11.2023.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    var presenter: GamePresenterProtocol?
    init(presenter: GamePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let leftRoadside: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()
    private let rightRoadside: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()
    private let leftRoad = UILayoutGuide()
    private let rightRoad = UILayoutGuide()
    private let viewRoad: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let scoreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.textAlignment = .center
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.delegate = self
        setupConstraints()
        presenter?.createCarController(view: view)
        presenter?.startGame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawDottedLine()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    deinit {
        print("deinit \(self)")
    }
}
extension GameViewController: IGameViewDelegate {
    func addObstacleOnRoad(obstacle: Obstacle, roadLane: RoadLane) {
        guard let presenter = presenter else { return }
        var layoutGuide: UILayoutGuide
        switch roadLane {
        case .left:
            layoutGuide = leftRoad
        case .right:
            layoutGuide = rightRoad
        }
        obstacle.addOnRoad(viewRoad: viewRoad, roadLane: layoutGuide)
        obstacle.startAnimation(animationSpeed: presenter.getAnimationSpeed()) { [weak presenter] in
            obstacle.removeFromRoad()
            presenter?.removeObstacle(obstacle: obstacle)
        }
    }
    func addPlayerOnRoad(player: Player, roadLane: RoadLane) {
        var layoutGuide: UILayoutGuide
        switch roadLane {
        case .left:
            layoutGuide = leftRoad
        case .right:
            layoutGuide = rightRoad
        }
        player.addPlayerOnRoad(viewRoad: viewRoad, direction: layoutGuide)
    }
    func showGameOver(score: String) {
        let alert = UIAlertController(title: "endGame.title".localized(), message: String(format: "endGame.message".localized(), score), preferredStyle: .alert)
        let actionBack = UIAlertAction(title: "endGame.back".localized(), style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        let actionRepeat = UIAlertAction(title: "endGame.repeat".localized(), style: .default) { [weak self] _ in
            self?.presenter?.startGame()
        }
        alert.addAction(actionBack)
        alert.addAction(actionRepeat)
        self.present(alert, animated: true, completion: nil)
    }
    func showScore(score: String) {
        self.scoreLabel.text = score
    }
}

extension GameViewController {
    func drawDottedLine() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.lineDashPattern = [14, 7]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: viewRoad.bounds.midX , y: 0), CGPoint(x: viewRoad.bounds.midX, y: viewRoad.frame.height)])
        shapeLayer.path = path
        viewRoad.layer.addSublayer(shapeLayer)
    }
    func setupConstraints() {
        view.addSubview(leftRoadside)
        view.addSubview(rightRoadside)
        view.addSubview(viewRoad)
        view.addSubview(scoreLabel)
        viewRoad.addLayoutGuide(leftRoad)
        viewRoad.addLayoutGuide(rightRoad)
        NSLayoutConstraint.activate([
            leftRoadside.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftRoadside.topAnchor.constraint(equalTo: view.topAnchor),
            leftRoadside.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftRoadside.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            
            rightRoadside.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightRoadside.topAnchor.constraint(equalTo: view.topAnchor),
            rightRoadside.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rightRoadside.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            
            viewRoad.leadingAnchor.constraint(equalTo: leftRoadside.trailingAnchor),
            viewRoad.trailingAnchor.constraint(equalTo: rightRoadside.leadingAnchor),
            viewRoad.topAnchor.constraint(equalTo: view.topAnchor),
            viewRoad.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            leftRoad.leadingAnchor.constraint(equalTo: viewRoad.leadingAnchor),
            leftRoad.trailingAnchor.constraint(equalTo: viewRoad.centerXAnchor),
            leftRoad.topAnchor.constraint(equalTo: viewRoad.topAnchor),
            leftRoad.bottomAnchor.constraint(equalTo: viewRoad.safeAreaLayoutGuide.bottomAnchor),
            
            rightRoad.leadingAnchor.constraint(equalTo: viewRoad.centerXAnchor),
            rightRoad.trailingAnchor.constraint(equalTo: viewRoad.trailingAnchor),
            rightRoad.topAnchor.constraint(equalTo: viewRoad.topAnchor),
            rightRoad.bottomAnchor.constraint(equalTo: viewRoad.safeAreaLayoutGuide.bottomAnchor),
            
            scoreLabel.centerXAnchor.constraint(equalTo: viewRoad.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: viewRoad.topAnchor, constant: Constants.offset32),
            scoreLabel.widthAnchor.constraint(equalTo: viewRoad.widthAnchor, multiplier: 0.6),
            scoreLabel.heightAnchor.constraint(equalTo: scoreLabel.widthAnchor, multiplier: 0.3)
        ])
    }
}

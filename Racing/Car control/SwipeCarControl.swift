//
//  SwipeCarControl.swift
//  Racing
//
//  Created by Olga on 30.12.2023.
//

import Foundation
import UIKit

class SwipeCarControl: CarControl {
    override init(view: UIView) {
        super.init(view: view)
        setupRecognizers()
    }
    private func setupRecognizers() {
        view.addGestureRecognizer(createGesture(for: .left))
        view.addGestureRecognizer(createGesture(for: .right))
    }
    private func createGesture(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeGesture.direction = direction
        return swipeGesture
    }
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            delegate?.onMoveRight()
        } else if gesture.direction == .left {
            delegate?.onMoveLeft()
        }
    }
}

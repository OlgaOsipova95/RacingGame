//
//  TapCarControl.swift
//  Racing
//
//  Created by Olga on 30.12.2023.
//

import Foundation
import UIKit

class TapCarControl: CarControl {
    override init(view: UIView) {
        super.init(view: view)
        setupRecognizers()
    }
    
    private func setupRecognizers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    @objc private func onTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        if location.x < view.bounds.midX {
            delegate?.onMoveLeft()
        } else {
            delegate?.onMoveRight()
        }
    }
}

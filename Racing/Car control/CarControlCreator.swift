//
//  CarControlCreator.swift
//  Racing
//
//  Created by Olga on 30.12.2023.
//

import Foundation
import UIKit

class CarControlCreator {
    static func create(type: GameSettings.Control, view: UIView) -> CarControl {
        switch type {
        case .swipe:
            return SwipeCarControl(view: view)
        case .tap:
            return TapCarControl(view: view)
        case .accelerometer:
            return AccelerometerCarControl(view: view)
        }
    }
}

//
//  CarControl.swift
//  Racing
//
//  Created by Olga on 30.12.2023.
//

import Foundation
import UIKit

protocol CarControlDelegate: AnyObject {
    func onMoveRight()
    func onMoveLeft()
}

protocol CarControlProtocol {
    var delegate: CarControlDelegate? { get set }
    func start()
    func stop()
}

class CarControl: CarControlProtocol {
    weak var delegate: CarControlDelegate?
    var view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    func start() {
        
    }
    func stop() {
        
    }
    deinit {
        print("deinit \(self)")
    }
}

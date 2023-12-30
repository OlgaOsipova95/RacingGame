//
//  AccelerometerCarControl.swift
//  Racing
//
//  Created by Olga on 30.12.2023.
//

import Foundation
import UIKit
import CoreMotion

class AccelerometerCarControl: CarControl {
    private let motion = CMMotionManager()
    private var timer: Timer?
    override init(view: UIView) {
        super.init(view: view)
    }
    
    override func start() {
        startAccelerometers()
    }
    
    override func stop() {
        guard motion.isAccelerometerAvailable else { return }
        timer?.invalidate()
        timer = nil
        motion.stopAccelerometerUpdates()
    }
    
    private func startAccelerometers() {
        guard motion.isAccelerometerAvailable else { return }
        motion.accelerometerUpdateInterval = 1.0 / 30.0
        motion.startAccelerometerUpdates()
        
        timer = Timer(fire: Date(), interval: (1.0/30.0),
                      repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            guard let data = self.motion.accelerometerData else { return }
            let x = data.acceleration.x
            if x > Constants.accelerometerMinX {
                self.delegate?.onMoveRight()
            } else if x < -Constants.accelerometerMinX {
                self.delegate?.onMoveLeft()
            }
        })
        guard let timer = timer else { return }
        RunLoop.current.add(timer, forMode: .default)
    }
}

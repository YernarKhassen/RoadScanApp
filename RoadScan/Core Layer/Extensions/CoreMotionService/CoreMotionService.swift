//
//  CoreMotionService.swift
//  InRoad
//
//  Created by Адема Сапакова on 27.03.2023.
//

import CoreMotion

struct CoreMotionViewModel {
    var xPosition: Double
    var yPosition: Double
    var zPosition: Double
}

enum DetectableSpeed {
    case carIsDriving
    case carIsNotDriving
}

protocol CoreMotionServiceDelegate: AnyObject {
    func getCoordinateMotionDevice(with data: CoreMotionViewModel)
//    func getDetectableSpeedState(with state: DetectableSpeed)
    func getDetectableSpeedState(state: DetectableSpeed, rate: Double)
}

final class CoreMotionService {
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue()
    var lastUpdateTime: TimeInterval = 0
    var velocity: Double = 0
    
    var carIsDrivingStart: (() -> ())?

    
    weak var delegate: CoreMotionServiceDelegate?
    
    func startMotion() {
        motionManager.startDeviceMotionUpdates(to: motionQueue) { [weak self]
            (data: CMDeviceMotion?, error: Error?) in
            
            guard let self = self,
                  let data = data else {
                return
            }
            
            let motion: CMAttitude = data.attitude
            self.motionManager.deviceMotionUpdateInterval = 0.6
            
            self.delegate?.getCoordinateMotionDevice(with: .init(xPosition: motion.roll,
                                                                 yPosition: motion.yaw,
                                                                 zPosition: motion.pitch))
        }
    }
   
    func speedDetecting() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                    guard let self = self, let motion = motion else { return }
                    let currentTime = motion.timestamp
                    
                    if self.lastUpdateTime != 0 {
                        let deltaTime = currentTime - self.lastUpdateTime
                        let acceleration = motion.userAcceleration.z
                        self.velocity = (acceleration * deltaTime)
                        
                        let x = motion.userAcceleration.x * motion.userAcceleration.x
                        let y = motion.userAcceleration.y * motion.userAcceleration.x
                        let z = motion.userAcceleration.x * motion.userAcceleration.x
                        
                        let res = sqrt((x*x) + (y*y) + (z*z))
                        
                        if res < 1.5 && res > 0.5 {
                            carIsDrivingStart?()
                        }
                    }
                    
                    self.lastUpdateTime = currentTime
                }
    }
}



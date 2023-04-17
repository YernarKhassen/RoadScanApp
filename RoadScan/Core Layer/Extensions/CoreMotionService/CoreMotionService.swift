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
                        
                        var x = motion.userAcceleration.x * motion.userAcceleration.x
                        var y = motion.userAcceleration.y * motion.userAcceleration.x
                        var z = motion.userAcceleration.x * motion.userAcceleration.x
                        
                       // var res = sqrt()
                        
                        if(self.velocity > 0) && motion.userAcceleration.x > 0.0004 || motion.userAcceleration.y > 1 || motion.userAcceleration.z > 0.0004 {
                            self.delegate?.getDetectableSpeedState(state: DetectableSpeed.carIsDriving, rate: motion.userAcceleration.x)
                        } else {
                            self.delegate?.getDetectableSpeedState(state : DetectableSpeed.carIsNotDriving, rate: -1)
                        }
                    }
                    
                    self.lastUpdateTime = currentTime
                }
    }
}



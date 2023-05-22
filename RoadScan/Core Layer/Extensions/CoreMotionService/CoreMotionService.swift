import CoreMotion

enum DangerLvlState: String {
    case low = "l"
    case medium = "m"
    case hight = "h"
}

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
    private let motionManager = CMMotionManager()
    private let motionQueue = OperationQueue()
    private let onceCall = OnceCall()
    
    var carIsDrivingStart: ((DangerLvlState) -> ())?
    
    func startMotion() {
        motionManager.startDeviceMotionUpdates(to: motionQueue) { [weak self]
            (data: CMDeviceMotion?, error: Error?) in
            
            guard let self = self,
                  let _ = data else {
                return
            }
            
            self.motionManager.deviceMotionUpdateInterval = 0.6
        }
        
        self.dangerZoneDetecting()
    }
    
    func dangerZoneDetecting() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let self = self,
                  let motion = motion else { return }
            
            let x = motion.userAcceleration.x * motion.userAcceleration.x
            let y = motion.userAcceleration.y * motion.userAcceleration.y
            let z = motion.userAcceleration.z * motion.userAcceleration.z
            
            let unevenness = sqrt((x*x) + (y*y) + (z*z))

            if unevenness < 3 && unevenness >= 2 {
                self.onceCall.run {
                    self.carIsDrivingStart?(.low)
                }
            }
            
            if unevenness < 4 && unevenness >= 3 {
                self.onceCall.run {
                    self.carIsDrivingStart?(.medium)
                }
            }
            
            if unevenness > 5 {
                self.onceCall.run {
                    self.carIsDrivingStart?(.hight)
                }
            }
        }
    }
}


